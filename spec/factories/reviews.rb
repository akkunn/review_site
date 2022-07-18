FactoryBot.define do
  factory :review do
    name { "MyString" }
    curriculum { "MyText" }
    support { "MyText" }
    teacher { "MyText" }
    compatibility { "MyText" }
    thought { "MyText" }
    user_id { 1 }
    school_id { 1 }
    curriculum_star { 1.5 }
    support_star { 1.5 }
    teacher_star { 1.5 }
    compatibility_star { 1.5 }
  end
end
