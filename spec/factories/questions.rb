FactoryBot.define do
  factory :question do
    name { "MyString" }
    content { "MyText" }
    user { nil }
    school { nil }
  end
end
