FactoryBot.define do
  factory :question do
    name { "転職できますか？" }
    content { "転職サポートはどの程度あるのでしょうか？" }
    user_id { 1 }
    school_id { 1 }
    solution { 0 }
  end
end
