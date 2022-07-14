require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario "user sign up" do
    user = FactoryBot.build(:user, name: "example", email: "rails@rails.com")

    visit root_path
    click_link "新規登録"
    fill_in "ユーザー名", with: user.name
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    fill_in "パスワード確認", with: user.password
    click_button "新規登録する"

    expect(page).to have_content "Please follow the link to activate your account."
  end

  scenario "user log in" do
    user = FactoryBot.create(:user)

    visit root_path
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    expect(page).to have_content "Signed in successfully."
  end

  scenario "user log out" do
    user = FactoryBot.create(:user)

    sign_in(user)
    visit root_path
    click_link "ログアウト"
    expect(page).to have_content "Signed out successfully."
  end
end
