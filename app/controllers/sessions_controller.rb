class SessionsController < ApplicationController
	def new
	  
	end

	def create
		user = User.find_by_email(params[:email])
		if user && user.password == params[:password]
			sign_in user

			if user.student_id
				teacher = user.get_user_contact[0]
				student = user.get_user_contact[1]
				redirect_to student_path teacher, student
			else
				redirect_to user
			end
		else
			flash[:error] = 'Invalid email/password combination' 
      render :new
    end
	end

	def destroy
		sign_out
		redirect_to login_path
	end
end