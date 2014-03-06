class ContactsController < ApplicationController

  before_filter :get_user, only: [:index, :new, :create, :edit, :show, :lesson_info]
  before_filter :get_contact, only: [:show, :edit, :update, :destroy, :lesson_info]


  def index
    @contacts = @user.contacts
    @assignments = @user.get_recent_assignments
    @pending = @user.get_pending_assignments
  end

  def new
    @contact = Contact.new
    render partial: 'new', :locals => { contact: @contact, user: @user }
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.user = @user
    if @contact.save
      @contacts = Contact.all
      user_params = @contact.generate_user_params
      user = User.new(user_params[:user])
      user.password = user_params[:password]
      user.save
      @contacts = @user.contacts

      render partial: 'show', locals: { contact: @contact }
    else
      render nothing: true, status: 200, content_type: 'type/html'
    end
  end

  def show
    @assignments = @contact.assignments
    @requests = @contact.requests
    render partial: 'show', :locals => { contact: @contact }
  end

  def edit
    render partial: 'edit', :locals => { user: @user, contact: @contact }
  end

  def update
    @contact.update_attributes(params[:contact])
    render partial: 'show', :locals => { contact: @contact }
  end

  def destroy
    @contact.destroy
    render partial: 'delete_message'
  end

  def student
    @user = User.find(params[:user_id])
    @contact = Contact.find(params[:id])
    @assignments = @contact.assignments
    @payments = Payment.where(student_id: current_user.student_id)
    PaymentProfile.setup_client @user
    @requests = @contact.requests
    render layout: "student"
  end

  def lesson_info
    @assignments = @contact.assignments
    @requests = @contact.requests
    render partial: 'lesson_info', :locals => { contact: @contact }
  end


  private

  def get_user
    @user = User.find(params[:user_id])
  end

  def get_contact
    @contact = Contact.find(params[:id])
  end
end

