require 'BCrypt'

class User < ActiveRecord::Base
  include BCrypt

  attr_accessible :name, :email
  has_many :appointments
  validates :email, uniqueness: true
  validates :email, format: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :name, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password= (new_password)
    validate_password_length(new_password)

    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.create_with_password(user_attributes, password)
    user = self.new user_attributes
    user.password = password
    user.save!
    user
  end

  private

  def validate_password_length(password)
    if (password.length < 6)
      raise ArgumentError.new "Password must be at least 6 characters"
    end
  end
end
