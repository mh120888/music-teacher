class RequestsController < ApplicationController
	before_filter :get_user_contact

	def new
	end

	def create
		@request = Request.create(params[:request])
		@contact.requests << @request
		render 'show', :layout => false
	end

private

	def get_user_contact
		@user = User.find(params[:user_id])
		@contact = Contact.find(params[:contact_id])
	end
end
