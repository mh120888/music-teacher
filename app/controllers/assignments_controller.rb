class AssignmentsController < ApplicationController
before_filter :get_user_contact

def new
	@assignment = Assignment.new
	render :new, :layout => false
end

def create
	Request.find(params[:request_id]).destroy
	@assignment = Assignment.create(params[:assignment])
	@contact.assignments << @assignment 
	redirect_to student_path @user, @contact
end


private

	def get_user_contact
		@user = User.find(params[:user_id])
		@contact = Contact.find(params[:contact_id])
	end
end