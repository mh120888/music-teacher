class UsersController < ApplicationController
  def new
    @user = User.new
    if params[:user]
      @old_email = params[:user][:email]
    end
  end
  def create
    @user = User.new(params[:user])
    @user.password = params[:password]
    if @user.save
      redirect_to @user
    else
      @old_name = @user.name
      @old_email = @user.email
      @user = User.new
      render :new
    end
  end
  def show
    @user = User.find(params[:id])
  end
end