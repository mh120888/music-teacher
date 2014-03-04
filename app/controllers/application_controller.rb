class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :punt_student, :except => [ :student, :destroy, :create, :update ]


  include SessionsHelper

  def signed_in_user
    redirect_to login_path, notice: "Please sign in" unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to current_user unless current_user?(@user)
  end

  def punt_student
		if current_user && current_user.student_id
			teacher = current_user.get_user_contact[0]
			student = current_user.get_user_contact[1]
			redirect_to student_path teacher, student 
		end
  end
end
