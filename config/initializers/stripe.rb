Rails.configuration.stripe = {
  :secret_key => ENV['SECRET_KEY'],
  :publishable_key => ENV['PUBLISHABLE_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]


# "sk_test_AwRVQJXyOKmxigs7Q6ldSmxq"
# "pk_test_3QMZN844k2Yf7kvxb2naKwDi"

# SECRET_KEY=sk_test_AwRVQJXyOKmxigs7Q6ldSmxq PUBLISHABLE_KEY=pk_test_3QMZN844k2Yf7kvxb2naKwDi rails s