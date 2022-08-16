require 'rails_helper'

RSpec.describe "Searches", type: :system do
  let!(:school) { FactoryBot.create(:school) }

  before do
    driven_by(:rack_test)
  end

  scenario "user searches schools" do
    visit root_path
    within '.school-search-box' do
      fill_in "q_name_cont", with: school.name
      select school.language.name, from: "q_language_id_eq"
      select school.cost.range, from: "q_cost_id_eq"
      select school.period.range, from: "q_period_id_eq"
      select school.style, from: "q_style_eq"
      select school.prefecture.name, from: "q_prefecture_id_eq"
      select school.support, from: "q_support_eq"
      select school.guarantee, from: "q_guarantee_eq"
      click_button "検索"
    end
    expect(page).to have_content(school.name)
  end
end
