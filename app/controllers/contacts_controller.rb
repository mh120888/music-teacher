class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
  end
  def new
    @contact = Contact.new
    render partial: "new", locals: {contact: @contact}
  end
end