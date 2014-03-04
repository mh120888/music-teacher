class DashboardController < ApplicationController
  def index
    @appointment = Appointment.new
    @appointments_by_date = Appointment.upcoming_grouped_by_date
    @date = Date.today
  end

  def lesson
    render 'dashboard/lesson/page'
  end
end