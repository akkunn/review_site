require 'rails_helper'

RSpec.describe "FavoriteReviews", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:school) { FactoryBot.create(:school) }
  let!(:review) { FactoryBot.create(:review, user_id: user.id, school_id: school.id) }

  scenario "user likes a review", js: true do
    visit root_path
    find('#menu-button').click
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    expect(page).to have_content "ログインしました。"
    click_button "検索"
    click_link school.name
    expect {
      click_link nil, href: create_favorite_review_path(review)
      expect(page).to have_content(1)
      expect(review.reload.favorite_reviews.count).to eq(1)
    }.to change(review.favorite_reviews, :count).by(1)
  end

  scenario "user deletes a favorite_review", js: true do
    FactoryBot.create(:favorite_review, user_id: user.id, review_id: review.id)
    visit root_path
    find('#menu-button').click
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    expect(page).to have_content "ログインしました。"
    click_button "検索"
    click_link school.name
    expect {
      click_link nil, href: destroy_favorite_review_path(review)
      expect(page).to have_content(0)
      expect(review.reload.favorite_reviews.count).to eq(0)
    }.to change(review.favorite_reviews, :count).by(-1)
  end
end
