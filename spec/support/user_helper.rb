module UserHelper

  def self.attributes_without_password
    user_attributes = FactoryGirl.attributes_for(:user)
    user_attributes.delete(:password_hash)
    user_attributes
  end
end