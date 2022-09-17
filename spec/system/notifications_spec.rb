require 'rails_helper'

RSpec.describe "Notifications", type: :system do
  let(:user1) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user) }
  let!(:school) { FactoryBot.create(:school) }
  let!(:review) { FactoryBot.create(:review, user_id: user2.id, school_id: school.id) }
  let(:question) { FactoryBot.create(:question, user_id: user2.id, school_id: school.id) }
  let!(:answer) { FactoryBot.create(:answer, user_id: user1.id, question_id: question.id) }

  scenario "user adds a new notification", js: true do
    visit root_path
    find('#menu-button').click
    click_link "ログイン"
    fill_in "メールアドレス", with: user1.email
    fill_in "パスワード", with: user1.password
    click_button "ログイン"
    click_button "検索"
    click_link school.name
    expect {
      click_link nil, href: create_favorite_review_path(review)
      expect(page).to have_content(1)
      expect(user2.reload.passive_notifications.count).to eq(1)
    }.to change(Notification, :count).by(1)
    visit root_path
    find('#menu-button').click
    click_link "ログアウト"
    visit root_path
    find('#menu-button').click
    click_link "ログイン"
    fill_in "メールアドレス", with: user2.email
    fill_in "パスワード", with: user2.password
    click_button "ログイン"
    find('#menu-button').click
    click_link "通知"
    expect(page).to have_content("通知")
    expect(page).to have_content(user1.name)
  end

  scenario "user deletes a notification" do
    FactoryBot.create(:notification,
                      review_id: review.id, visited_id: user2.id, visiter_id: user1.id)
    sign_in_as(user2)
    visit root_path
    within '.header-pc' do
      click_link "通知"
    end
    click_link "削除"
    expect(user2.reload.passive_notifications.count).to eq(0)
    expect(page).not_to have_content(user1.name)
    expect(page).not_to have_content(review.name)
    expect(page).to have_content("通知はありません")
  end

  scenario "user deletes all notifications" do
    FactoryBot.create(:notification,
                      review_id: review.id, visited_id: user2.id, visiter_id: user1.id)
    FactoryBot.create(:notification,
                      question_id: question.id, answer_id: answer.id,
                      visited_id: user2.id, visiter_id: user1.id, action: 'answer')
    sign_in_as(user2)
    visit root_path
    within '.header-pc' do
      click_link "通知"
    end
    click_link "全削除"
    expect(user2.reload.passive_notifications.count).to eq(0)
    expect(page).not_to have_content(user1.name)
    expect(page).not_to have_content(review.name)
    expect(page).not_to have_content(answer.content)
    expect(page).to have_content("通知はありません")
  end
end
