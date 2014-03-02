class PaymentProfile < ActiveRecord::Base
  attr_accessible :access_token, :publishable_key

   def self.access_client_account(code)
    get_client_access(get_client_info(code))
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

  # def email_for(payment)
  #   payment["card"]["name"]
  # end

  # def amount_for(payment)
  #   "$#{(payment["amount"] / 100.0)}"
  # end

  # def date_for(payment)
  #   DateTime.strptime(payment["created"].to_s,'%s')
  # end

  # def username(account)
  #   account.retrieve.display_name
  # end

  # def name_for(plan)
  #   plan["name"]
  # end

  # def description_for(plan)
  #   "$#{plan["amount"] / 100.0} each #{plan["interval"]}"
  # end

  # def subscribers_for(plan)
  #   Stripe::Customer.all.select do |cust|
  #     cust.subscriptions.data[0] && cust.subscriptions.data[0].plan.id == plan.id
  #   end
  # end

  private

  def self.get_client_info(code) #get's accesstoken and publishable key for the user
    ActiveSupport::JSON.decode(`curl -X POST https://connect.stripe.com/oauth/token -d client_secret=#{ENV['SECRET_KEY']} -d code=#{code} -d grant_type=authorization_code -d scope=read_write`)
  end

  def self.get_client_access(client)
    Stripe.api_key = client['access_token']
    Rails.configuration.stripe[:publishable_key] = client['stripe_publishable_key']
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
