require 'rails_helper'

RSpec.describe "Reviews", type: :system do
  let!(:school) { FactoryBot.create(:school) }
  let(:user) { FactoryBot.create(:user) }
  before do
    driven_by(:rack_test)
  end

  scenario "user adds new review" do
    sign_in_as(user)
    visit new_review_path
    expect {
      select school.name, from: "review_school_id"
      fill_in "review_name", with: "おすすめです"
      find('#curriculum-star', visible: false).set(3)
      fill_in "review_curriculum", with: "難しい"
      find('#support-star', visible: false).set(2.5)
      fill_in "review_support", with: "普通"
      find('#teacher-star', visible: false).set(4)
      fill_in "review_teacher", with: "アドバイスが的確"
      find('#compatibility-star', visible: false).set(1.5)
      fill_in "review_curriculum", with: "両立は厳しい"
      fill_in "review_thought", with: "難しいが自分の力でできる人にはおすすめ"
      find('#user-id', visible: false).set(user.id)
      click_button "投稿する"
    }.to change(Review, :count).by(1)
    expect(page).to have_content("おすすめです")
  end
end
