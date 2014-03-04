class PaymentProfile < ActiveRecord::Base
    attr_accessible :access_token, :publishable_key
    belongs_to :user
    has_many :payments

   def self.access_client_account(code, user)
    get_client_access(get_client_info(code), user)
   end

  def self.charge_payment(params, customer)
    Stripe::Charge.create(customer: customer.id, amount: params[:amount].to_i * 100, currency: 'usd')
  end

  def self.charge_subscription(params, customer)
    customer.subscriptions.create({:plan => params[:plan_id]})
  end

  def self.charge(params)
    customer = generate_customer(params)
    params[:plan_id] ? charge_subscription(params, customer) : charge_payment(params, customer)
  end

  def self.assign_to(client, user)
    user.payment_profiles << PaymentProfile.create(access_token: client['access_token'], publishable_key: client['stripe_publishable_key'])
  end

  def self.setup_client(user)
    if user.payment_profiles.first
      payment_profile = user.payment_profiles.first
      Stripe.api_key = payment_profile[:access_token]
      Rails.configuration.stripe[:publishable_key] = payment_profile[:publishable_key]
      true
    end
  end

  def self.get_client_info(code) #get's accesstoken and publishable key for the user
    ActiveSupport::JSON.decode(`curl -X POST https://connect.stripe.com/oauth/token -d client_secret=#{ENV['SECRET_KEY']} -d code=#{code} -d grant_type=authorization_code -d scope=read_write`)
  end

  private

  def self.get_client_access(client, user)
    Stripe.api_key = client['access_token']
    Rails.configuration.stripe[:publishable_key] = client['stripe_publishable_key']
    assign_to(client, user)
  end

  def self.generate_customer(params)
    customer = find_customer_by_email(params[:stripeEmail])
    if customer_exists?(customer)
      customer
    else
      create_new_customer(params)
    end
  end

  def self.customer_exists?(customer)
    !customer.nil?
  end

  def self.find_customer_by_email(email)
    Stripe::Customer.all.select {|cust| cust.email == email}.first
  end

  def self.create_new_customer(params)
    Stripe::Customer.create(:email => params[:stripeEmail], :card => params[:stripeToken])
  end

end
