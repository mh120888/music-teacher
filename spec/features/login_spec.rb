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

    describe 'loging in' do
      context 'with valid user data' do
        let!(:user) { FactoryGirl.create(:user) }

        before(:each)do
          fill_in "email", with: user.email
          fill_in "password", with: "password"
          click_on "Log In"
        end

        it 'should send me to my dashboard page' do
          expect(page).to have_content("Welcome #{user.name}")
        end

        describe 'logging out' do
          before(:each) do
            click_link "Log Out"
          end

          it 'should return you to Log In page' do
            expect(page).to have_content("Log In")
          end
        end
      end
      context 'with invalid user data' do
        before(:each) do
          click_on "Log In"
        end

        it 'should send me back to login' do
          expect(page).to have_content("Log In")
        end

        it 'should send me a flash error message' do
          expect(page).to have_selector('div.error')
        end
      end
    end
  end
end