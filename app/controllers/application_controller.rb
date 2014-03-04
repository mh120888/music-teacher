class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def signed_in_user
    redirect_to login_path, notice: "Please sign in" unless signed_in?
  end

  # authorize_user
  def correct_user
    @user = User.find(params[:id])
    redirect_to current_user unless current_user?(@user)
  end
end
