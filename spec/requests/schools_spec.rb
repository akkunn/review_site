require 'rails_helper'

RSpec.describe "Schools", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:school) { FactoryBot.create(:school) }

  describe "#index" do
    it "return http success" do
      get schools_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "#new" do
    context "as an authenticated user" do
      before do
        sign_in user
        get new_school_path
      end

      it "return http success" do
        expect(response).to have_http_status(:success)
      end

      it "exists a correct page" do
        expect(response.body).to include("プログラミングスクールを登録する")
      end
    end
  end

  describe "#create" do
    before do
      sign_in user
    end

    context "as an authorized user" do
      it "adds a new school" do
        school_params = FactoryBot.attributes_for(:school)
        expect {
          post schools_path, params: { school: school_params }
        }.to change { School.count }.by(1)
      end
    end
  end

  # describe "#create" do
  #   it "return http success" do
  #     get new_school_path
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
