FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Andy#{n}" }
    sequence(:email) { |n| "Andy#{n}@example.com" }
    password "password"
  end
end