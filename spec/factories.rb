require 'bcrypt'

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Andy#{n}" }
    sequence(:email) { |n| "Andy#{n}@example.com" }
    password_hash BCrypt::Password.create "password"
  end
end