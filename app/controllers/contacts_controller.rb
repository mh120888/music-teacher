class ContactsController < ApplicationController
  

  def index
    @user = User.find(params[:user_id])
    @contacts = @user.contacts
    @assignments = @user.get_recent_assignments
    @pending = @user.get_pending_assignments
  end



  def new
    @user = User.find(params[:user_id])
    @contact = Contact.new
    render partial: 'new'
  end


  def create
    @contact = Contact.new(params[:contact])
    @contact.user_id = params[:user_id]
    if @contact.save
      @contacts = Contact.all
      user_params = @contact.generate_user_params
      user = User.new(user_params[:user])
      user.password = user_params[:password]
      user.save
      render partial: 'list'
    else
      @user = User.find(params[:user_id])
      render partial: 'new'
    end
  end

  
  def show
    @user = User.find(params[:user_id])
    @contact = Contact.find(params[:id])
    @assignments = @contact.assignments
    @requests = @contact.requests
    render partial: 'show', :locals => { contact: @contact }
  end
  def edit
    @user = User.find(params[:user_id])
    @contact = Contact.find(params[:id])
    render partial: 'edit', :locals => { user: @user, contact: @contact }
  end
  def update
    @contact = Contact.find(params[:id])
    @contact.update_attributes(params[:contact])
    render partial: 'show', :locals => { contact: @contact }
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    render :json => @contact.user_id
  end

  def student
    @user = User.find(params[:user_id])
    @contact = Contact.find(params[:id])
    @assignments = @contact.assignments
    @payments = Payment.where(student_id: current_user.student_id)
    #current_user.setup_student_payment
    PaymentProfile.setup_client @user


    p current_user
    p @user
    p "00" * 500




    @requests = @contact.requests
  end
end