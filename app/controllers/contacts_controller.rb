class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
    @contact = Contact.new
  end
  def new
    @contact = Contact.new
  end
  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      @contacts = Contact.all
      render partial: 'list'
    else
      render 'new'
    end
  end
end