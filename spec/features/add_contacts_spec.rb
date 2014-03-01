require 'spec_helper'

describe 'Adding contacts' do
  describe 'contact creation form' do
    it 'should say "create contact"' do
      visit new_contact_path
      expect(page).to have_content('Create Contact')
    end
  end
end