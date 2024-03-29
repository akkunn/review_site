require 'rails_helper'

RSpec.describe "Answers", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:school) { FactoryBot.create(:school) }
  let(:question) { FactoryBot.create(:question, user_id: other_user.id, school_id: school.id) }
  let!(:answer) { FactoryBot.create(:answer, user_id: user.id, question_id: question.id) }

  scenario "user adds a new answer" do
    sign_in_as user
    expect {
      visit question_path(question)
      fill_in "answer_content", with: "卒業後もサポートしてもらえます"
      click_button "回答する"
      expect(current_path).to eq question_path(question)
      expect(page).to have_content("回答を投稿しました")
      expect(page).to have_content("卒業後もサポートしてもらえます")
    }.to change(user.answers, :count).by(1)
  end

  scenario "user updates a answer", js: true do
    visit root_path
    find('#menu-button').click
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    expect(page).to have_content "ログインしました。"
    visit question_path(question)
    expect(page).to have_content("面接対策をしてくれます")
    click_link "編集する", href: edit_answer_path(answer)
    fill_in "answer-edit-textarea", with: "転職についての情報をたくさん入手できます"
    click_button "変更"
    expect(page).to have_content("転職についての情報をたくさん入手できます")
    expect(page).to have_content("回答を変更しました")
  end

  scenario "user deletes a answer" do
    sign_in_as(user)
    expect {
      visit question_path(question)
      click_link "削除する", href: answer_path(answer)
      expect(page).not_to have_content(answer.content)
    }.to change(user.answers, :count).by(-1)
  end
end
