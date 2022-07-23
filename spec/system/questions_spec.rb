require 'rails_helper'

RSpec.describe "Questions", type: :system do
  let!(:school) { FactoryBot.create(:school) }
  let!(:other_school) { FactoryBot.create(:school) }
  let(:user) { FactoryBot.create(:user) }
  let(:question) { FactoryBot.create(:question, user_id: user.id, school_id: school.id) }


  before do
    driven_by(:rack_test)
  end

  scenario "user adds a new question" do
    sign_in_as(user)
    visit new_question_path
    expect {
      select school.name, from: "question_school_id"
      fill_in "question_name", with: "railsを学びたいです"
      fill_in "question_content", with: "カリキュラムはどんな感じですか？"
      click_button "投稿する"
    }.to change { Question.count }.by(1)
    expect(current_path).to eq questions_path
    expect(page).to have_content(user.name)
    expect(page).to have_content("railsを学びたいです")
  end

  scenario "user updates a question" do
    sign_in_as(user)
    visit edit_question_path(question)
    select other_school.name, from: "question_school_id"
    fill_in "question_name", with: "難易度について"
    fill_in "question_content", with: "カリキュラムは何ヶ月あれば終わりますか？"
    click_button "変更する"
    expect(current_path).to eq questions_path
    expect(page).to have_content(user.name)
    expect(page).to have_content("難易度について")
  end
end
