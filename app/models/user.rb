require 'BCrypt'

class User < ActiveRecord::Base
  include BCrypt

  attr_accessible :name, :email

  def password
    @password ||= Password.new(password_hash)
  end

  def password= (new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.create_with_password(user_attributes, password)
    user = self.new user_attributes
    user.password = password
    user.save!
    user
  end
end