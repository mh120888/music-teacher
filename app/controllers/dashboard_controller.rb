class DashboardController < ApplicationController
  def index
    if current_user
      @user = current_user
      @appointment = Appointment.new
      @appointments_by_date = Appointment.upcoming_grouped_by_date(current_user)
      @date = Date.today
      @contacts = @user.contacts
      @contact = Contact.new
      @assignments = current_user.get_recent_assignments
      @pending = current_user.get_pending_assignments
      @feed = (@assignments + @pending).sort_by(&:created_at).reverse
    end
  end

  def lesson
    render 'dashboard/lesson/page'
  end
end