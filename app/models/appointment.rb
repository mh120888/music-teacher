class Appointment < ActiveRecord::Base
  attr_accessible :title, :description, :date, :end_time, :start_time, :student_id, :user_id
  validates :date, presence: true
  belongs_to :user
end
