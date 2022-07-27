FactoryBot.define do
  factory :answer do
    content { "面接対策をしてくれます" }
    user { 1 }
    question { 1 }
  end
end
