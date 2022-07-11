require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:school) { School.new(name: "ポテパンキャンプ") }
  let(:user_school) { UserSchool.new(user_id: user.id, school_id: school.id)}
  let(:other_user) { FactoryBot.create(:user) }

  describe "#show" do
    it "returns a 200 response" do
      sign_in(user)
      get user_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe "#edit" do
    context "as an authenticated user" do
      before do
        sign_in user
        get edit_user_path(user)
      end
      it "returns a 200 response" do
        expect(response).to have_http_status(200)
      end

      it "has correct user name" do
        expect(response.body).to include(user.name)
      end
    end

    context "as a not authenticated user" do
      it "redirects to home page" do
        sign_in user
        get edit_user_path(other_user)
        expect(response).to redirect_to root_path
      end
    end

    context "as guest" do
      it "redirect to the sign_in page" do
        get edit_user_path(user)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#update" do
    context "as an authorized user" do
      it "updates a profile" do
        sign_in user
        # binding.pry
        patch user_path(user), params: { id: user.id, user: { name: "ruby", email: user.email, user_school: { user_id: user_school.user_id, school_id: user_school.school_id } } }
        expect(user.reload.name).to eq "ruby"
      end
    end

    context "as an unautorized user" do
      before do
        sign_in user
      end

      it "does not update the profile" do
        patch user_path(other_user), params: { id: other_user.id, user: { name: "ruby", email: other_user.email, user_school: { user_id: user_school.user_id, school_id: user_school.school_id } } }
        expect(user.reload.name).to eq "rails"
      end

      it "redirects to home page" do
        patch user_path(other_user), params: { id: other_user.id, user: { name: "ruby", email: other_user.email, user_school: { user_id: user_school.user_id, school_id: user_school.school_id } } }
        expect(response).to redirect_to root_path
      end
    end

    context "as a guest" do
      it "redirects to the sign-in page" do
        patch user_path(user), params: { id: user.id, user: { name: "ruby", email: user.email, user_school: { user_id: user_school.user_id, school_id: user_school.school_id } } }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
