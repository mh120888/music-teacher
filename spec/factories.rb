require 'spec_helper'

FactoryGirl.define do
  factory :appointment do
    title       { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    date        { Date.today }
    start_time  { Time.now }
    end_time    { Time.now + (60 * 60)}
  end
end