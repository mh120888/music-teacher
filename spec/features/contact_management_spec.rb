require 'spec_helper'

describe 'Contact Management', js: true do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:contact) { FactoryGirl.create(:contact, user: user) }
  describe 'adding a contact' do
    let!(:contact_params) { FactoryGirl.attributes_for(:contact) }
    before(:each) do
      visit new_user_contact_path user
    end

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
  end
end

