FactoryBot.define do
  factory :school do
    name { "ポテパンキャンプ" }
    style { "オンライン" }
    support { "あり" }
    guarantee { "あり" }
    explanation { "難しい" }
    language_id { 7 }
    prefecture_id { 13 }
    cost_id { 6 }
    period_id { 3 }
  end
end