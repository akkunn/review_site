FactoryBot.define do
  factory :notification do
    visiter_id { 1 }
    visited_id { 2 }
    review_id { 1 }
    answer_id { 1 }
    question_id { 1 }
    action { "like" }
    checked { false }
  end
end
