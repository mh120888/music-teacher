class ContactsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @contacts = Contact.all
    @contact = Contact.new
  end
  def new
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
end