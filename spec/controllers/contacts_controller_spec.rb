require 'spec_helper'

describe ContactsController do
  let!(:user) { FactoryGirl.create(:user) }
  context '#new' do
    before(:each) do
      get :new, user_id: user.id
    end
    it 'assigns a new contact and it should not be persisted' do
      expect(assigns(:contact)).to be_an_instance_of Contact
      expect(assigns(:contact).persisted?).to be_false
    end
  end
  context '#create' do
    let!(:contact_params) { FactoryGirl.attributes_for(:contact) }
    it 'increases number of contacts by one' do
      expect {
        post :create, user_id: user.id, contact: contact_params
      }.to change { Contact.count }.by(1)
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
  context '#edit' do
    let!(:contact) { FactoryGirl.create(:contact) }
    before(:each) do
      get :edit, user_id: user.id, id: contact.id
    end
    it 'assigns the correct contact' do
      expect(assigns(:contact).id).to eq contact.id
    end
  end
  context '#destroy' do
    let!(:contact) { FactoryGirl.create(:contact) }
    it 'removes the contact from active record' do
      expect {
        delete :destroy, user_id: user.id, id: contact.id
      }.to change{ Contact.count }.by(-1)
    end
  end
end








