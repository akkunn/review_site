require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario "user sign up" do
    user = FactoryBot.build(:user, name: "example", email: "rails@rails.com")

    visit root_path
    click_link "新規登録"
    fill_in "Name", with: user.name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    click_button "Sign up"

    expect(page).to have_content "Please follow the link to activate your account."
  end

  scenario "user log in" do
    user = FactoryBot.create(:user)

    visit root_path
    click_link "ログイン"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
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
