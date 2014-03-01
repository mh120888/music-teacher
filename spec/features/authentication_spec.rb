require 'spec_helper'

describe 'Authentication' do

	describe 'for non-signed in users' do
		let!(:user) { FactoryGirl.create(:user) }
		before(:each) do
			visit user_path(user)
		end

		it 'should not allow user to access to any dashboard' do
			expect(page).not_to have_content "Welcome #{user.name}"
		end

		it 'should send to signin page' do
			expect(page).to have_content "Log In"
		end
	end

	describe 'for the wrong user' do
		let!(:user) { FactoryGirl.create(:user) }
		let!(:other_user) { FactoryGirl.create(:user) }

		before(:each) do
			visit login_path
      fill_in "email", with: other_user.email
      fill_in "password", with: "password"
      click_on "Log In"
			visit user_path(user.id)
		end

		it 'should not allow user to access dashboard' do
			expect(page).not_to have_content "Welcome #{user.name}"
		end
	end
end
