class Appointment < ActiveRecord::Base
  attr_accessible :title, :description, :date, :end_time, :start_time, :student_id, :user_id
  validates :date, presence: true
  belongs_to :user

  def self.group_by_date
    Appointment.all.sort_by(&:date).group_by(&:date)
    .map do |date, appts|
      appts.sort_by(&:start_time)
    end
  end
end
