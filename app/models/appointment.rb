class Appointment < ActiveRecord::Base
  attr_accessible :title, :description, :date, :end_time, :start_time, :student_id, :user_id
  validates :date, presence: true
  belongs_to :user

  def self.upcoming_grouped_by_date(user)
    appts_by_date = user.appointments.sort_by(&:date).group_by(&:date)
    grouped = {}
    appts_by_date.each do |date, appts|
      grouped[date] = appts.sort_by(&:start_time) if date.future?
    end
    grouped
  end
end
