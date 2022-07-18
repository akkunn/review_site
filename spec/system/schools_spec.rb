require 'rails_helper'

RSpec.describe "Schools", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    driven_by(:rack_test)
    @school = FactoryBot.create(:school)
  end

  scenario "user adds new school" do
    sign_in_as(user)
    visit new_school_path
    expect {
      within '.box' do
        fill_in "school_name", with: "ポテパンキャンプ"
        select "Ruby", from: "school_language_id"
        select "41~50万円", from: "school_cost_id"
        select "4ヶ月~半年", from: "school_period_id"
        select "オンライン", from: "school_style"
        select "東京都", from: "school_prefecture_id"
        select "あり", from: "school_support"
        select "あり", from: "school_guarantee"
        fill_in "school_explanation", with: "難しい"
        click_button "新規登録"
      end
    }.to change(School, :count).by(1)
    expect(page).to have_content("ポテパンキャンプ")
  end

  scenario "user updates school" do
    sign_in_as(user)
    visit edit_school_path(@school)
    within '.box' do
      fill_in "school_name", with: "ポテパンキャンプ"
      select "PHP", from: "school_language_id"
      select "31~40万円", from: "school_cost_id"
      select "~1ヶ月", from: "school_period_id"
      select "通学", from: "school_style"
      select "埼玉県", from: "school_prefecture_id"
      select "なし", from: "school_support"
      select "なし", from: "school_guarantee"
      fill_in "school_explanation", with: "難しいけど、頑張れる"
      click_button "変更する"
    end
    expect(page).to have_content("ポテパンキャンプ")
    expect(@school.reload.language_id).to eq 6
    expect(@school.reload.cost_id).to eq 5
    expect(@school.reload.period_id).to eq 1
    expect(@school.reload.style).to eq "通学"
    expect(@school.reload.prefecture_id).to eq 11
    expect(@school.reload.support).to eq "なし"
    expect(@school.reload.guarantee).to eq "なし"
    expect(@school.reload.explanation).to eq "難しいけど、頑張れる"
  end
end
