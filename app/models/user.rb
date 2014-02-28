class User < ActiveRecord::Base
  attr_accessible :name, :password, :email
  has_many :appointments
end