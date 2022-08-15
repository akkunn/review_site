require 'rails_helper'

RSpec.describe "UserSchools", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:school) { FactoryBot.create(:school) }
  let!(:user_school) { UserSchool.create(user_id: user.id, school_id: school.id) }


  describe "#destroy" do
    context "as an authorized user" do
      it "deletes a user_school" do
        sign_in user
        expect {
          delete user_school_path(user_school)
        }.to change { UserSchool.count }.by(-1)
      end
    end

    context "as an unauthorized user" do
      before do
        sign_in other_user
      end

      it "doesn't delete a user_school" do
        expect {
          delete user_school_path(user_school)
        }.not_to change { UserSchool.count }
      end

      it "redirects to user show page" do
        delete user_school_path(user_school)
        expect(response).to redirect_to user_path(user_school.user)
      end
    end

    context "as a guest" do
      before do
        delete user_school_path(user_school)
      end

      it "doesn't delete a user_school" do
        expect {
          delete user_school_path(user_school)
        }.not_to change { UserSchool.count }
      end

      it "redirects to login page" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
