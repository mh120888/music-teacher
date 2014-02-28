class Payment < ActiveRecord::Base
  attr_accessible :amount, :user_id

  def self.get_payment_access(code)
    ActiveSupport::JSON.decode(`curl -X POST https://connect.stripe.com/oauth/token -d client_secret=#{ENV['SECRET_KEY']} -d code=#{code} -d grant_type=authorization_code -d scope=read_write`)
  end
end
