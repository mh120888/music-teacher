require 'spec_helper'

describe PaymentProfilesController do
	let!(:user) { FactoryGirl.create(:user) }

	before(:each) do
		stub_login user	
	end

	context '#connect' do
		let(:publishable_key) { "a_pk" }
		let(:access_token) { "a_at" }
		let(:code) { "some_api_code"}
		before(:each) do
			PaymentProfile.stubs(:get_client_info).returns({'stripe_publishable_key' => publishable_key, 'access_token' => access_token})
		end

		it 'should add a row to payment profiles table' do
			expect {
				post :connect, code: code
			}.to change{ PaymentProfile.count }.by(1)
		end
		it 'should have the access_token and publishable_key' do
			post :connect, code: code
			expect(PaymentProfile.last.publishable_key).to eq publishable_key
			expect(PaymentProfile.last.access_token).to eq access_token
		end
	end

	context '#index' do
		let!(:payment_profile) { FactoryGirl.create(:payment_profile, user: user) }
		before do
			PaymentProfilesController.any_instance.stubs(:username).returns()
			get :index
		end

		it 'should store user instance' 
		it 'should store connected instance'
		it 'should store payments instance'

	end
end
