require 'rails_helper'

RSpec.describe "Questions", type: :system do
  let!(:school) { FactoryBot.create(:school) }
  # let!(:other_school) { FactoryBot.create(:school) }
  let(:user) { FactoryBot.create(:user) }
  # let!(:review) { FactoryBot.create(:review, user_id: user.id, school_id: school.id) }

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
    expect(page).to have_content(user.name)
    expect(page).to have_content("railsを学びたいです")
  end
end
