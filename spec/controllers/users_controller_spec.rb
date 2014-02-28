require 'spec_helper'

describe UsersController do
  context '#new' do
    it 'has access to a new user object' do
      get :new
      expect(assigns(:user)).to be_an_instance_of User
      expect(assigns(:user).persisted?).to be_false
    end
  end
  context '#create' do
    let!(:user_attributes) { UserHelper.attributes_without_password }
    let(:password) { "password" }
    it 'should increment user count by 1' do
      expect {
        post :create, user: user_attributes, password: password
      }.to change{ User.count }.by(1)
    end
  end
  context '#show' do
    let!(:user) { FactoryGirl.create(:user) }
    it 'stored the appropriate user' do
      get :show, id: user.id
      expect(assigns(:user).id).to eq(user.id)
    end
  end
end