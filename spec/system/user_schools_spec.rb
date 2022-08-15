require 'rails_helper'

RSpec.describe "UserSchools", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:school) { FactoryBot.create(:school) }
  let!(:user_school) { UserSchool.create(user_id: user.id, school_id: school.id) }

  before do
    driven_by(:rack_test)
  end

  scenario "user deletes a user_school" do
    sign_in_as(user)
    visit user_path(user)
    click_link "変更する"
    click_link "削除"
    expect(page).to have_content("なし")
    expect(user.reload.user_schools.first).to eq(nil)
  end
end
