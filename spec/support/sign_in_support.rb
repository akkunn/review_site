module SignInSupport
  def sign_in_as(user)
    visit root_path
    within '.header-pc' do
      click_link "ログイン"
    end
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    expect(page).to have_content "ログインしました。"
  end
end
