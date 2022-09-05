# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

School.create(
  name: "ポテパンキャンプ",
  style: "オンライン",
  support: "あり",
  guarantee: "あり",
  explanation: "難しい",
  language_id: 7,
  prefecture_id: 13,
  cost_id: 6,
  period_id: 3
)

15.times do |i|
  name = Faker::University.name
  School.create(
    name: "#{name} #{ 1 + i }",
    style: "通学",
    support: "あり",
    guarantee: "なし",
    explanation: "#{i} 楽しい",
    language_id: 1,
    prefecture_id: 1,
    cost_id: 1,
    period_id: 1
  )
end

15.times do |i|
  name = Faker::University.name
  School.create(
    name: "#{name} #{ 16 + i }",
    style: "オンライン",
    support: "なし",
    guarantee: "あり",
    explanation: "#{i} ワクワク",
    language_id: 2,
    prefecture_id: 2,
    cost_id: 2,
    period_id: 2
  )
end

15.times do |i|
  name = Faker::University.name
  School.create(
    name: "#{name} #{ 31 + i }",
    style: "通学とオンライン",
    support: "あり",
    guarantee: "あり",
    explanation: "#{i} 厳しい",
    language_id: 3,
    prefecture_id: 3,
    cost_id: 3,
    period_id: 3
  )
end

14.times do |i|
  name = Faker::University.name
  School.create(
    name: "#{name} #{ 46 + i }",
    style: "オンライン",
    support: "なし",
    guarantee: "なし",
    explanation: "#{i} 余裕",
    language_id: 4,
    prefecture_id: 4,
    cost_id: 4,
    period_id: 4
  )
end

AdminUser.create!(email: ENV['ADMIN_EMAIL'], password: ENV['ADMIN_PASSWORD'], password_confirmation: ENV['ADMIN_PASSWORD_CONFIRMATION'])

100.times do |i|
  user_name = Faker::Name.name
  User.create(
    email: "user#{ 1 + i }@example.com",
    name: user_name,
    password: "password#{ 1 + i }",
    confirmed_at: Time.now
  )
end
