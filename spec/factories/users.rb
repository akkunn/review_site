FactoryBot.define do
  factory :user do
    name { "rails" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "password" }
  end
end
