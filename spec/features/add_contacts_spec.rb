require 'spec_helper'

describe 'Adding contacts', js: true do
  describe 'viewing all contacts' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:contact) { FactoryGirl.create(:contact, user: user) }
    before(:each) do
      visit user_contacts_path user
    end
    it 'displays all contacts' do
      expect(page).to have_content "#{contact.first_name}"
      expect(page).to have_content "#{contact.last_name}"
    end
    it 'should allow me to navigate to the create contact page' do
      expect(page).to have_content 'Add New Contact'
      click_on 'Add New Contact'
      expect(page).to have_selector(:link_or_button, 'Create Contact')
    end
  end
  describe 'contact creation form' do
    let!(:user) { FactoryGirl.create(:user) }
    before(:each) do
      visit user_contacts_path user
      click_on 'Add New Contact'
    end
    it 'should have the correct fields' do
      expect(page).to have_button 'Create Contact'
      expect(page).to have_field 'contact_first_name'
      expect(page).to have_field 'contact_last_name'
      expect(page).to have_field 'contact_email'
      expect(page).to have_field 'contact_address'
      expect(page).to have_field 'contact_phone'
    end
    describe 'adding a contact' do
      let!(:contact_params) { FactoryGirl.attributes_for(:contact) }
      context 'with valid params' do
        it 'display all contacts page with newly added contact' do
          fill_in 'contact_first_name',  with: contact_params[:first_name]
          fill_in 'contact_last_name',   with: contact_params[:last_name]
          fill_in 'contact_email',       with: contact_params[:email]
          fill_in 'contact_address',     with: contact_params[:address]
          fill_in 'contact_phone',       with: contact_params[:phone]
          click_on 'Create Contact'
          expect(page).to have_content "#{contact_params[:first_name]}"
          expect(page).to have_content "#{contact_params[:last_name]}"
        end
      end
      context 'with invalid params' do
        before(:each) do
          fill_in 'contact_last_name',   with: contact_params[:last_name]
          fill_in 'contact_email',       with: contact_params[:email]
          fill_in 'contact_address',     with: contact_params[:address]
          fill_in 'contact_phone',       with: contact_params[:phone]
          click_on 'Create Contact'
        end
        it 'shows the add contact page' do
          expect(page).to have_content 'Add New Contact'
        end
        it 'adds "field_with_errors" class to page' do
          expect(page).to have_css '.field_with_errors'
        end
      end
    end
  end
  describe 'viewing a specific contact' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:contact) { FactoryGirl.create(:contact, user: user) }
    before(:each) do
      visit user_contacts_path user
      click_on "#{contact.first_name}"
    end
    it 'should show all of a contact\'s information after clicking on the name' do
      expect(page).to have_content contact.first_name
      expect(page).to have_content contact.last_name
      expect(page).to have_content contact.email
      expect(page).to have_content contact.address
      expect(page).to have_content contact.phone
    end
    it 'should show an edit button' do
      expect(page).to have_selector(:link_or_button, 'Edit')
    end
    it 'should show a delete button' do
      expect(page).to have_selector(:link_or_button, 'Delete')
    end
  end
  describe 'editing contacts' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:contact) { FactoryGirl.create(:contact, user: user) }
    before(:each) do
      visit user_contact_path user, contact
      click_on 'Edit'
    end
    context 'filling out form' do
      it 'displays a form to edit the contact\'s info' do
        expect(page).to have_field 'contact_first_name'
        expect(page).to have_field 'contact_last_name'
        expect(page).to have_field 'contact_email'
        expect(page).to have_field 'contact_address'
        expect(page).to have_field 'contact_phone'
      end
      it 'has a save button' do
        expect(page).to have_selector(:link_or_button, 'Save')
      end
    end
    context 'submitting form' do
      let!(:new_name) { 'President Business' }
      before(:each) do
        fill_in 'contact_first_name',  with: new_name
        click_on 'Save'
      end
      it 'redirects to the show page' do
        expect(page).to have_content(new_name)
      end
    end
  end
  describe 'deleting contact' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:contact) { FactoryGirl.create(:contact, user: user) }
    before do
      visit user_contacts_path user
      click_on "#{contact.first_name}"
      click_on "Delete"
    end

    it 'should remove conctact from list' do
      expect(page).not_to have_content(contact.first_name)
    end
  end
end

