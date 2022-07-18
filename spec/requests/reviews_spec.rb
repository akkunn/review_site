require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  # let(:review) { FactoryBot.create(:review) }
  let(:user) { FactoryBot.create(:user) }
  let(:school) { FactoryBot.create(:school) }
  let(:review_params) { FactoryBot.attributes_for(:review, user_id: user.id, school_id: school.id) }

  # describe "GET /index" do
  #   it "returns http success" do
  #     get "/reviews/index"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /show" do
  #   it "returns http success" do
  #     get "/reviews/show"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "#new" do
    context "as an authenticated user" do
      before do
        sign_in user
        get new_review_path
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "exists a correct page" do
        expect(response.body).to include("口コミ投稿")
        expect(response.body).to include(user.id.to_s)
      end
    end

    context "as a guest" do
      before do
        get new_review_path
      end

      it "redirect to login page" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#create" do
    context "as an authorized user" do
      before do
        sign_in user
      end

      it "adds a new review" do
        expect {
          post reviews_path, params: { review: review_params }
        }.to change { Review.count }.by(1)
      end
    end

    context "as a guest" do
      it "doesn't add a new review" do
        expect {
          post reviews_path, params: { review: review_params }
        }.not_to change { Review.count }
      end

      it "redirect to login page" do
        post reviews_path, params: { review: review_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end


end
