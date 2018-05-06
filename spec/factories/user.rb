require 'ffaker'

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "john#{n}@doe.com"
    end
    password "QQ123!!111"
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
  end
end
