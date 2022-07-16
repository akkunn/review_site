require 'rails_helper'

RSpec.describe "Schools", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:school) { FactoryBot.create(:school) }
  let(:school_params) { FactoryBot.attributes_for(:school) }

  describe "#index" do
    it "return http success" do
      get schools_path(signal: "review-count")
      expect(response).to have_http_status(:success)
    end

    it "exists all schools" do
      schools = []
      5.times do
        schools << FactoryBot.create(:school)
      end
      get schools_path(signal: "review-count")
      schools.all? do |school|
        expect(response.body).to include(school.name)
      end
    end
  end

  describe "#new" do
    context "as an authenticated user" do
      before do
        sign_in user
        get new_school_path
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "exists a correct page" do
        expect(response.body).to include("プログラミングスクールを登録する")
      end
    end

    context "as a guest" do
      it "redirects to login page" do
        get new_school_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#create" do
    context "as an authorized user" do
      before do
        sign_in user
      end

      it "adds a new school" do
        expect {
          post schools_path, params: { school: school_params }
        }.to change { School.count }.by(1)
      end
    end

    context "as a guest" do
      it "doesn't a new school" do
        expect {
          post schools_path, params: { school: school_params }
        }.not_to change { School.count }
      end

      it "redirects to login page" do
        post schools_path, params: { school: school_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#edit" do
    context "as an authorized user" do
      before do
        sign_in user
        get edit_school_path(school)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "exists a correct page" do
        expect(response.body).to include("プログラミングスクールの情報を変更する")
        expect(response.body).to include(school.name)
      end
    end

    context "as a guest" do
      it "redirects to login page" do
        get edit_school_path(school)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#update" do
    context "as an authorized user" do
      let(:school) { FactoryBot.create(:school) }
      let(:update_params) { FactoryBot.attributes_for(:school, id: school.id, name: "ポテパン") }

      before do
        sign_in user
      end

      it "update a school information" do
        patch school_path(school), params: { school: update_params }
        expect(school.reload.name).to eq "ポテパン"
      end
    end

    context "as a guest" do
      it "doesn't a new school" do
        expect {
          post schools_path, params: { school: school_params }
        }.not_to change { School.count }
      end

      it "redirects to login page" do
        post schools_path, params: { school: school_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
