class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:show]
  before_filter :correct_user, only: [:show]

  def new
    @user = User.new
    @old_email = params[:user][:email] if params[:user]
  end
  def create
    @user = User.new(params[:user])
    @user.password = params[:password]
    if @user.save
      sign_in @user
      redirect_to @user
    else
      @old_name = @user.name
      @old_email = @user.email
      @user = User.new
      render :new
    end
  end

  def show
  end
end
