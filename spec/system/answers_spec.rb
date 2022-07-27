require 'rails_helper'

RSpec.describe "Answers", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:school) { FactoryBot.create(:school) }
  let(:question) { FactoryBot.create(:question, user_id: other_user.id, school_id: school.id) }

  before do
    driven_by(:rack_test)
  end

  scenario "user adds a new answer" do
    sign_in_as user
    visit question_path(question)
    fill_in "answer_content", with: "卒業後もサポートしてもらえます"
    click_button "回答する"
    expect(current_path).to eq question_path(question)
    expect(page).to have_content("卒業後もサポートしてもらえます")
  end
end
