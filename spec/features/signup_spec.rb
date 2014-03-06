require 'spec_helper'

describe 'User signup', :js => true do
  before(:each) do
    visit root_path
    click_on "Start Using Backlyne"
  end

  describe "submitting a form to sign up" do

    context "with valid data" do
      let!(:user_attributes) { UserHelper.attributes_without_password }
      before(:each) do
        fill_in "user_name", :with => user_attributes[:name]
        fill_in "Email", :with => user_attributes[:email]
        fill_in "Password", :with => "password"
        click_button('Create Account')
      end
      it 'sends the user to the dashboard' do
        expect(page).to have_content("Activity Feed")
      end
    end

    context "with invalid data" do
      let!(:user_attributes) { UserHelper.attributes_without_password }
      before(:each) do
        fill_in "Email", :with => user_attributes[:email]
        fill_in "Password", :with => "password"
        click_button('Create Account')
      end
      it 'renders the landing page again' do
        expect(page).to have_content('We let you concentrate on being a great teacher, not on running a business.')
      end
    end
  end
end