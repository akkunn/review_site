require 'rails_helper'

RSpec.describe "Searches", type: :system do
  let(:school) { FactoryBot.create(:school) }
  before do
    driven_by(:rack_test)
  end

  scenario "user searches schools" do
    visit root_path
    fill_in "スクール名", with: school.name
    select school.language.name, from: "学習言語"
    click_button "検索"
    expect(page).to have_content(school.name)
  end
end
