class SessionsController < ApplicationController
	def new
	  
	end

	def create
		user = User.find_by_email(params[:email])
		if user && user.password == params[:password]
			sign_in user
			redirect_to user
		else
			flash[:error] = 'Invalid email/password combination' # Not quite right!
      render :new
    end
	end

	def destroy
		sign_out
		redirect_to login_path
	end
end