require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  before_create :create_remember_token

  attr_accessible :name, :email, :student_id
  attr_accessor :student_id
  attr_reader :name
  has_many :appointments
  has_many :contacts
  has_many :payment_profiles

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

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.create_with_contact(contact_info)
    self
  end

  def get_user_contact
    contact = Contact.find(student_id)
    user = contact.user 
    [user, contact]
  end

  def get_recent_assignments
    self.contacts.map {|contact| contact.assignments}.flatten.sort_by {|assignment| assignment.created_at}[0..4] 
  end

  def get_pending_assignments
    self.contacts.map {|contact| contact.requests}.flatten
  end

  private

  def validate_password_length(password)
    if (password.length < 6)
      raise ArgumentError.new "Password must be at least 6 characters"
    end
  end

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
