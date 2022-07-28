require 'rails_helper'

RSpec.describe "Questions", type: :system do
  let(:school) { FactoryBot.create(:school) }
  let!(:other_school) { FactoryBot.create(:school) }
  let(:user) { FactoryBot.create(:user) }
  let!(:question) { FactoryBot.create(:question, user_id: user.id, school_id: school.id) }
  let!(:solved_question_noanswer) {
    FactoryBot.create(:question, name: "カリキュラムについて", user_id: user.id, school_id: school.id, solution: 2)
  }
  let(:solved_question) {
    FactoryBot.create(:question, name: "学習期間について", user_id: user.id, school_id: school.id, solution: 2)
  }
  let!(:answer_solved_question) { FactoryBot.create(:answer, user_id: user.id, question_id: solved_question.id) }

  before do
    driven_by(:rack_test)
  end

  scenario "user adds a new question" do
    sign_in_as(user)
    visit questions_path(school_id: school.id)
    click_link "質問する"
    expect {
      select school.name, from: "question_school_id"
      fill_in "question_name", with: "railsを学びたいです"
      fill_in "question_content", with: "カリキュラムはどんな感じですか？"
      click_button "投稿する"
    }.to change { Question.count }.by(1)
    expect(current_path).to eq questions_path
    expect(page).to have_content(user.name)
    expect(page).to have_content("railsを学びたいです")
    expect(page).to have_content("質問を投稿しました")
  end

  scenario "user updates a question" do
    sign_in_as(user)
    visit questions_path(school_id: school.id)
    click_link question.name
    click_link "編集する"
    select other_school.name, from: "question_school_id"
    fill_in "question_name", with: "難易度について"
    fill_in "question_content", with: "カリキュラムは何ヶ月あれば終わりますか？"
    click_button "変更する"
    expect(page).to have_content(other_school.name)
    expect(page).not_to have_content(school.name)
    expect(page).to have_content(user.name)
    expect(page).to have_content("難易度について")
    expect(page).to have_content("質問を変更しました")
  end

  scenario "user deletes a question" do
    sign_in_as(user)
    visit questions_path(school_id: school.id)
    click_link question.name
    click_link "削除する"
    expect(page).not_to have_content(question.name)
  end

  scenario "user solves a question" do
    sign_in_as(user)
    visit questions_path(school_id: school.id)
    click_link question.name
    click_link "解決した"
    expect(question.reload.solution).to eq 2
    expect(page).to have_content("解決済み")
    expect(page).to have_content("解決済みに変更しました")
  end

  scenario "user changes from solved question to unsolved question when answer is nil" do
    sign_in_as(user)
    visit questions_path(school_id: school.id)
    click_link solved_question_noanswer.name
    click_link "解決した"
    expect(solved_question_noanswer.reload.solution).to eq 0
    expect(page).to have_content("未回答")
    expect(page).to have_content("未回答に変更しました")
  end

  scenario "user changes from solved question to unsolved question when an answer exists" do
    sign_in_as(user)
    visit questions_path(school_id: school.id)
    click_link solved_question.name
    click_link "解決した"
    expect(solved_question.reload.solution).to eq 1
    expect(page).to have_content("回答済み")
    expect(page).to have_content("回答済みに変更しました")
  end
end
