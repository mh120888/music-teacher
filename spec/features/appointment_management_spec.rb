require 'spec_helper'

describe 'Creating Appointments', js: true do
  describe 'viewing all appointments' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:appt) { FactoryGirl.create(:appointment, user: user) }
    let!(:other_user) { FactoryGirl.create(:user) }
    let!(:other_appt) { FactoryGirl.create(:appointment, user: other_user) }
    before(:each) do
      visit login_path
      fill_in 'email', with: user.email
      fill_in 'password', with: 'password'
      click_on 'Log In'
      visit root_path
    end
    it 'shows only my appointments on my dashboard' do
      expect(page).to have_content "#{appt.title}"
      expect(page).not_to have_content "#{other_appt.title}"
    end
  end
end