class ContactsController < ApplicationController
  before_filter :get_user, only: [:index, :new, :create, :edit, :destroy]
  before_filter :get_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = @user.contacts
  end
  def new
    @contact = Contact.new
    render partial: 'new', :locals => { contact: @contact, user: @user }
  end
  def create
    @contact = Contact.new(params[:contact])
    @contact.user = @user
    if @contact.save
      @contacts = @user.contacts
      render partial: 'list'
    else
      render partial: 'new', :locals => { user: @user, contact: @contact }
    end
  end
  def show
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
    @contacts = @user.contacts
    render partial: 'list'
  end

  private

  def get_user
    @user = User.find(params[:user_id])
  end

  def get_contact
    @contact = Contact.find(params[:id])
  end
end