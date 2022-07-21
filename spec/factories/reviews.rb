FactoryBot.define do
  factory :review do
    name { "転職したいならおすすめです" }
    curriculum { "難しい" }
    support { "質問にしっかり対応してくれます" }
    teacher { "現場の知識を教えてくれます" }
    compatibility { "両立させるには、かなりの努力が必要です" }
    thought { "難しいけど、自走力がつきます" }
    user_id { 1 }
    school_id { 1 }
    curriculum_star { 1.5 }
    support_star { 2.5 }
    teacher_star { 4 }
    compatibility_star { 5 }
    average_star { 3.5 }
  end
end
