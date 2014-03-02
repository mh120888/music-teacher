class Payment < ActiveRecord::Base
  belongs_to :payment_profile
  attr_accessible :amount
end