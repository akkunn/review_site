require 'rails_helper'

RSpec.describe "Reviews", type: :system do
  let!(:school) { FactoryBot.create(:school) }
  let!(:other_school) { FactoryBot.create(:school) }
  let(:user) { FactoryBot.create(:user) }
  let!(:review) { FactoryBot.create(:review, user_id: user.id, school_id: school.id) }
  before do
    driven_by(:rack_test)
  end

  scenario "user adds new review" do
    sign_in_as(user)
    visit new_review_path
    expect {
      select school.name, from: "review_school_id"
      fill_in "review_name", with: "おすすめです"
      find('#new-curriculum-star', visible: false).set(3)
      fill_in "review_curriculum", with: "難しい"
      find('#new-support-star', visible: false).set(2.5)
      fill_in "review_support", with: "普通"
      find('#new-teacher-star', visible: false).set(4)
      fill_in "review_teacher", with: "アドバイスが的確"
      find('#new-compatibility-star', visible: false).set(5)
      fill_in "review_compatibility", with: "両立は厳しい"
      fill_in "review_thought", with: "難しいが自分の力でできる人にはおすすめ"
      find('#user-id', visible: false).set(user.id)
      click_button "投稿する"
    }.to change(Review, :count).by(1)
    expect(page).to have_content("おすすめです")
    expect(page).to have_content("3.5点")
  end

  scenario "user updates a review" do
    sign_in_as(user)
    visit edit_review_path(review)
    expect(review.name).to eq("転職したいならおすすめです")

    select other_school.name, from: "review_school_id"
    fill_in "review_name", with: "エンジニアを目指しましょう"
    find('#edit-curriculum-star', visible: false).set(3)
    fill_in "review_curriculum", with: "自走力が身につきます"
    find('#edit-support-star', visible: false).set(4.5)
    fill_in "review_support", with: "転職支援があります"
    find('#edit-teacher-star', visible: false).set(2)
    fill_in "review_teacher", with: "的確なアドバイスがもらえます"
    find('#edit-compatibility-star', visible: false).set(1.5)
    fill_in "review_compatibility", with: "厳しい"
    fill_in "review_thought", with: "やり切りましょう"
    click_button "変更する"

    expect(review.reload.name).to eq("エンジニアを目指しましょう")
    expect(page).to have_content("エンジニアを目指しましょう")
    expect(page).to have_content("自走力が身につきます")
    expect(page).to have_content("転職支援があります")
    expect(page).to have_content("的確なアドバイスがもらえます")
    expect(page).to have_content("厳しい")
    expect(page).to have_content("やり切りましょう")
    expect(page).to have_content("3.0点")
  end
end
