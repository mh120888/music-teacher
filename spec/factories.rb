require 'bcrypt'

FactoryGirl.define do
  factory :appointment do
    title       { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    date        { Date.today }
    start_time  { Time.now }
    end_time    { Time.now + (60 * 60)}
  end
  factory :user do
    sequence(:name) { |n| "Andy#{n}" }
    sequence(:email) { |n| "Andy#{n}@example.com" }
    password_hash BCrypt::Password.create "password"
  end
  factory :payment_profile do
    access_token "some_at"
    publishable_key "some_pk"
    user
  end
end
