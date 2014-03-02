require 'spec_helper'

describe ContactsController do
  let!(:user) { FactoryGirl.create(:user) }
  context '#index' do
    before(:each) do
      get :index, user_id: user.id
    end
    it 'should be ok' do
      expect(response).to be_ok
    end
    it 'should retrieve all existing contacts' do
      expect(assigns(:contacts)).to eq Contact.all
    end
  end
  context '#create' do
    let!(:contact_params) { FactoryGirl.attributes_for(:contact) }
    it 'increases number of contacts by one' do
      expect {
        post :create, user_id: user.id, contact: contact_params
      }.to change { Contact.count }.by 1
    end
    it 'creates a contact that belongs to the specified user' do
      post :create, user_id: user.id, contact: contact_params
      expect(Contact.last.user_id).to eq user.id
    end
  end
  context '#show' do
    let!(:contact) { FactoryGirl.create(:contact) }
    before(:each) do
      get :show, user_id: user.id, id: contact.id
    end
    it 'should be ok' do
      expect(response).to be_ok
    end
    it 'should assign the correct contact' do
      expect(assigns(:contact).id).to eq contact.id
    end
  end 
  context '#edit'
  context '#destroy'
end