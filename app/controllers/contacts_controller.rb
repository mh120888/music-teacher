class ContactsController < ApplicationController

  before_filter :get_user, only: [:index, :new, :create, :edit, :show]
  before_filter :get_contact, only: [:show, :edit, :update, :destroy]


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
      render partial: 'list'
    else
      render partial: 'new', :locals => { user: @user, contact: @contact }
    end
  end

  
  def show
    @assignments = @contact.assignments
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
    render :json => @contact.user_id
  end

  def student
    @user = User.find(params[:user_id])
    @contact = Contact.find(params[:id])
    @assignments = @contact.assignments
    @payments = Payment.where(student_id: current_user.student_id)
    PaymentProfile.setup_client @user
    @requests = @contact.requests

  private

  def get_user
    @user = User.find(params[:user_id])
  end

  def get_contact
    @contact = Contact.find(params[:id])

  end
end