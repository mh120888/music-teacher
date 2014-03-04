class DashboardController < ApplicationController
  # merge index and index_partial
  def index
    @appointment = Appointment.new
    @appointments_by_date = Appointment.upcoming_grouped_by_date
    @date = Date.today
  end

  def index_partial
    @appointment = Appointment.new
    @appointments_by_date = Appointment.upcoming_grouped_by_date
    @date = Date.today
    render 'appointments'
  end

  def lesson
    render 'dashboard/lesson/page'
  end

  def lesson_partial
    render 'dashboard/lesson/page', layout: false
  end
end
