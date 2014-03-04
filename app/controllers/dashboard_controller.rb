class DashboardController < ApplicationController
  def index
    @user = current_user
    @appointment = Appointment.new
    @appointments_by_date = Appointment.upcoming_grouped_by_date
    @date = Date.today
    @contacts = Contact.all
  end

  def lesson
    render 'dashboard/lesson/page'
  end
end