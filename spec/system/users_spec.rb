require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario "user sign up" do
    user = FactoryBot.build(:user, name: "example", email: "rails@rails.com")
    visit root_path
    within '.header-pc' do
      click_link "新規登録"
    end
    fill_in "ユーザー名", with: user.name
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    fill_in "パスワード確認", with: user.password
    click_button "新規登録する"

    expect(page).to have_content "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"
  end

  scenario "user log in" do
    user = FactoryBot.create(:user)
    sign_in_as(user)
  end

  scenario "user log out" do
    user = FactoryBot.create(:user)
    sign_in_as(user)
    visit root_path
    within '.header-pc' do
      click_link "ログアウト"
    end
    expect(page).to have_content "ログアウトしました。"
  end
end
