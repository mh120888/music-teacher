class ContactsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @contacts = @user.contacts
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
      render partial: 'list'
    else
      @user = User.find(params[:user_id])
      render partial: 'new'
    end
  end
  def show
    @contact = Contact.find(params[:id])
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
    redirect_to 'index'
  end
end