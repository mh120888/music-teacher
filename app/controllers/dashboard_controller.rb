class DashboardController < ApplicationController
  def index
    @user = current_user
    @appointment = Appointment.new
    @appointments_by_date = Appointment.upcoming_grouped_by_date
    @date = Date.today
    @contacts = Contact.all
    @contact = Contact.new
    @assignments = current_user.get_recent_assignments
    @pending = current_user.get_pending_assignments
    @feed = (@assignments + @pending).sort_by(&:created_at)
  end

  def lesson
    render 'dashboard/lesson/page'
  end
end