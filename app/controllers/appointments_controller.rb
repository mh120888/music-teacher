class AppointmentsController < ApplicationController

  def index
    @appointment = Appointment.new
    @appointments = Appointment.all
    @appointments_by_date = @appointments.group_by(&:date)
    @date = Date.today
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
    @appointment = Appointment.new
  end

  def edit
    @appointment = Appointment.find(params[:id])
    render partial: 'edit', locals: { appointment: @appointment }
  end

  def create
    @appointment = Appointment.new(params[:appointment])
    if @appointment.save
      redirect_to appointments_path, notice: 'Appointment was successfully created.'
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
    redirect_to appointments_url
  end
end
