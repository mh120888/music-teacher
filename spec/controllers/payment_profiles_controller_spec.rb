require 'spec_helper'

describe PaymentProfilesController do
	let!(:user) { FactoryGirl.create(:user) }

	before do 
		stub_login user	
	end

	context '#connect' do
		it 'should add a row to payment profiles table' do
			binding.pry
			expect {
				post :connect, code: "some_api_code"
			}.to change{ PaymentProfile.count }.by(1)
			binding.pry
		end
	end

	context '#index' do

	end
end
