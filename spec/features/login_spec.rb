require 'spec_helper'

describe 'User login' do
  describe 'should have a form to log in' do
    before(:each) do
      visit login_path
    end
    it 'should have content that says "log in"' do
      expect(page).to have_content("Log In")
    end
    it 'should have the user model fields' do
      expect(page).to have_field('Email')
      expect(page).to have_field('Password')
    end
    it 'should have a submit button' do
      expect(page).to have_button('Log In')
    end
  end

  describe 'loging in' do
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