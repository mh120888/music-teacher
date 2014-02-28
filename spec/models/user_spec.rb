require 'spec_helper'

describe User do
  it { should have_many(:appointments) }
  subject(:user) { User.new }

  describe "password saving" do
    let(:password) { "password" }
    it 'password is stored as encrypted hash' do

      user_attributes = UserHelper.attributes_without_password
      new_user = User.create_with_password(user_attributes, password)

      expect(new_user.password_hash.to_s).not_to eq "password"
    end
  end
end
