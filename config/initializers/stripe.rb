Rails.configuration.stripe = {
  :secret_key => ENV['SECRET_KEY'],
  :publishable_key => ENV['PUBLISHABLE_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]


# "sk_test_AwRVQJXyOKmxigs7Q6ldSmxq"
# "pk_test_3QMZN844k2Yf7kvxb2naKwDi" OLD!!!!!!


# sk_test_166bPvjUMTCPSLMBZfaSIF8h

# pk_test_XIKcMP299HSjm2Vmif5JkxJn
