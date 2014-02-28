require 'spec_helper'

describe 'User login' do
  describe 'should have a form to sign in' do
    before(:each) do
      visit signin_path
    end
    it 'should have content that says "sign in"' do
      expect(page).to have_content("Sign In")
    end
    it 'should have the user model fields' do
      expect(page).to have_field('Email')
      expect(page).to have_field('Password')
    end
    it 'should have a submit button' do
      expect(page).to have_button('Sign In')
    end
  end

  describe 'signing in' do
    context 'with valid user data' do
      it 'should send me to my dashboard page' do
        pending
        expect(page).to have_content("Welcome #{user_attributes[:name]}")
      end
    end
    context 'with invalid user data' do
    end
  end
end