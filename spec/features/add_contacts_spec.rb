require 'spec_helper'

describe 'Adding contacts' do
  describe 'viewing all contacts' do
    let!(:contact) { FactoryGirl.create(:contact) }
    before(:each) do
      visit contacts_path
    end
    it 'displays all contacts' do
      expect(page).to have_content "#{contact.first_name}"
      expect(page).to have_content "#{contact.last_name}"
    end
    it 'should allow me to navigate to the create contact page' do
      expect(page).to have_content 'Add New Contact'
      click_on 'Add New Contact'
      expect(current_path).to eq new_contact_path
    end
  end
  describe 'contact creation form' do
    it 'should say "create contact"' do
      visit contacts_path
      click_on 'Add New Contact'
      expect(page).to have_button 'Create Contact'
    end
  end
  describe 'viewing a specific contact' do
  end
  describe 'editing contacts' do
  end
end
