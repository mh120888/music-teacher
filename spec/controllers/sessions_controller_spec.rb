require 'spec_helper'

describe SessionsController do
	context '#new' do
		it 'should take us to a valid form' do
			get :new
			expect(response).to be_success
		end
	end

	context '#create' do
		let!(:user) { FactoryGirl.create(:user) }
		
		it 'should save the session' do
			post :create, email: user.email, password: "password"
			user.reload
			remember_token = response.cookies["remember_token"]
			expect(User.encrypt(remember_token)).to eq user.remember_token
		end
	end

	context '#destroy' do
		let!(:user) { FactoryGirl.create(:user) }
		before(:each) do
			post :create, email: user.email, password: "password"
		end

		it 'should remove the remember_token in cookies' do
			delete :destroy
			expect(response.cookies.keys).to include "remember_token"
			expect(response.cookies["remember_token"]).to be_nil
		end
	end
end
