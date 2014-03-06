require 'spec_helper'

describe 'User login', js: true do
  describe 'logging in' do
    let!(:user) { FactoryGirl.create(:user) }
    context 'with valid user data' do

      before(:each) do
        visit root_path
        click_on "Sign In"
        fill_in "email", with: user.email
        fill_in "password", with: "password"
        click_on "Log In"
      end

      it 'sends the user to the dashboard' do
        expect(page).to have_content("Activity Feed")
      end

      describe 'logging out' do
        before(:each) do
          click_link "Log Out"
        end

        it 'returns user to the landing page' do
          expect(page).to have_content("We let you concentrate on being a great teacher, not on running a business.")
        end
      end
    end
    context 'with invalid user data' do
      before(:each) do
        visit root_path
        click_on "Sign In"
        fill_in "email", with: user.email
        fill_in "password", with: "notmypassword"
        click_on "Log In"
      end

      it 'should send me back to landing page' do
        expect(page).to have_content("We let you concentrate on being a great teacher, not on running a business.")
      end
    end
  end
end