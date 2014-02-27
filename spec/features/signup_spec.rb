require 'spec_helper'

describe 'User signup' do
  describe 'should have a form to sign up' do
    before(:each) do
      visit new_user_path
    end
    it 'should have content that says "sign up"' do
      expect(page).to have_content('Sign Up')
    end
    it 'should have the user model fields' do
      expect(page).to have_field('Name')
      expect(page).to have_field('Email')
      expect(page).to have_field('Password')
    end
    it 'should have a submit button' do
      expect(page).to have_button('Create Account')
    end

    describe "submitting a form to sign up" do

      context "with valid data" do
        let!(:user_attributes) { FactoryGirl.attributes_for(:user) }
        before(:each) do
          fill_in "user_name", :with => user_attributes[:name]
          fill_in "Email", :with => user_attributes[:email]
          fill_in "Password", :with => user_attributes[:password]
          click_button('Create Account')
        end
        it 'should send me to my dashboard page' do
          expect(page).to have_content("Welcome #{user_attributes[:name]}")
        end
      end

      context "with invalid data" do

      end

    end
  end
end