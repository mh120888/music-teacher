class PaymentProfile < ActiveRecord::Base
  attr_accessible :access_token, :publishable_key
end
