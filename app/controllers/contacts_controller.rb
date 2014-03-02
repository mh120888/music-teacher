class ContactsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @contacts = Contact.all
    @contact = Contact.new
  end
  def create
    @contact = Contact.new(params[:contact])
    @contact.user_id = params[:user_id]
    if @contact.save
      @contacts = Contact.all
      render partial: 'list'
    else
      render 'new'
    end
  end
  def show
    @contact = Contact.find(params[:id])
    render partial: 'show', :locals => { contact: @contact }
  end
end