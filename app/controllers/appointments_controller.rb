class AppointmentsController < ApplicationController

  def index
    user = current_user
    @appointment = Appointment.new
    @appointments_by_date = Appointment.upcoming_grouped_by_date(user)
    @date = Date.today
    render partial: 'index', layout: false
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
    @appointment = Appointment.new
  end

  def edit
    @appointment = Appointment.find(params[:id])
    render partial: "form", locals: { appointment: @appointment }
  end

  def create
    user = current_user
    @appointment = Appointment.new(params[:appointment])
    @appointment.user_id = user.id
    if @appointment.save
      @appointments_by_date = Appointment.upcoming_grouped_by_date(user)
      render partial: 'list', notice: 'Appointment was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update_attributes(params[:appointment])
      render partial: 'show', locals: { appointment: @appointment },
       notice: 'Appointment was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    render partial: "delete_confirmation"
  end
end
