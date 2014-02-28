module PaymentHelper
  def get_client_info(code)
    ActiveSupport::JSON.decode(`curl -X POST https://connect.stripe.com/oauth/token -d client_secret=#{ENV['SECRET_KEY']} -d code=#{code} -d grant_type=authorization_code -d scope=read_write`)
  end

  def get_client_access(client)
    Stripe.api_key = client['access_token']
    Rails.configuration.stripe[:publishable_key] = client['stripe_publishable_key']
  end

  def charge(params)
    customer = generate_customer(params)

    Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => params[:amount].to_i * 100,
      :description => 'Rails Stripe customer',
      :currency    => 'usd',
      :created     => Time.now
    )
  end

  def email_for(payment)
    payment["card"]["name"]
  end

  def amount_for(payment)
    "$" + (payment["amount"] / 100.0).to_s
  end

  def date_for(payment)
    DateTime.strptime(payment["created"].to_s,'%s')
  end

  private

  def generate_customer(params)
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :card  => params[:stripeToken]
    )
  end
end