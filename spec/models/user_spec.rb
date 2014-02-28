require 'spec_helper'

describe User do
  subject(:user) { User.new }

  context 'validation' do
    context 'email' do
      it { should validate_uniqueness_of :email }
      it { should allow_value('andy@example.com').for(:email) }
      it { should_not allow_value('andy@@example.com').for(:email) }
    end
    context 'name' do
      it { should validate_presence_of :name }
    end
  end

  describe "password saving" do
    let(:password) { "password" }
    it 'password is stored as encrypted hash' do

      user_attributes = UserHelper.attributes_without_password
      new_user = User.create_with_password(user_attributes, password)

      expect(new_user.password_hash.to_s).not_to eq "password"
    end

    describe 'password complexity' do
      let(:user_params) { UserHelper.attributes_without_password }
      let(:user) { User.new user_params}

      context 'should have miniumum of 6 characters' do
        it 'will raise exception with less than 6 chars' do
          expect {
            user.password = "as"
            user.save
          }.to raise_error(ArgumentError)
        end

        it 'will not raise exception with 6 or more characters' do
          expect {
            user.password = "a"*6
            user.save
          }.not_to raise_error
        end
      end
    end
  end
end