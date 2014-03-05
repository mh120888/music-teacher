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
		let!(:username) { "some name" }
		let!(:charge_data) do
			{ 
				"data" => [
					{
						"created" => Time.now.to_i,
						"card" => {
							"name" => "shkurkin@thisislongstuff.com"
							},
						"amount" => 2000
					}	
				]
			}
		end
		let!(:plan_data) do
			{
				"data" => [
					{
						"name" => "weekly lessons aaron blake",
						"amount" => 2500,
						"interval" => "week"
					}
				]
			}
		end
		let!(:payments) { [mock('payment')] }

		before(:each) do
			PaymentProfilesController.any_instance.stubs(:username).returns(username)
			PaymentProfilesController.stubs(:setup_client).returns(true)
			Stripe::Charge.stubs(:all).returns(charge_data)
			Stripe::Plan.stubs(:all).returns(plan_data)
			PaymentProfile.any_instance.stubs(:payments).returns(payments)
			get :index
		end

		it 'should store user instance' do
			expect(assigns(:user)).to eq username
		end

		it 'should store connected status' do
			expect(assigns(:connected)).to be_true
		end

		it 'should store payments instance' do
			expect(assigns(:payments)).to eq charge_data
		end

		it 'should store subscriptions instance' do
			expect(assigns(:plans)).to eq plan_data
		end

		it 'should store outstanding payments' do
			expect(assigns(:outstanding).length).to eq payments.length
		end
	end
end
