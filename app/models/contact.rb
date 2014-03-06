class Contact < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :address, :phone, :id
  validates :first_name, presence: true
  belongs_to :user
  has_many :assignments
  has_many :requests

  def full_name
    "#{first_name} #{last_name}"
  end

  def generate_user
  	user_params = {:user => {:name => first_name + last_name, :email => email, :student_id => id}, :password => "music_student"}
    user = User.new(user_params[:user])
    user.password = user_params[:password]
    user.save
  end
end