class Contact < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :address, :phone
  validates :first_name, presence: true
end