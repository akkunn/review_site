require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let(:review) { FactoryBot.create(:review, user_id: user.id, school_id: school.id) }
  let(:user) { FactoryBot.create(:user) }
  let(:school) { FactoryBot.create(:school) }
  let(:review_params) { FactoryBot.attributes_for(:review, user_id: user.id, school_id: school.id) }

  # describe "GET /index" do
  #   it "returns http success" do
  #     get "/reviews/index"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "#show" do
    before do
      get review_path(review)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "displays correct page" do
      expect(response.body).to include(review.name)
      expect(response.body).to include(review.curriculum)
      expect(response.body).to include(review.curriculum_star.to_s)
      expect(response.body).to include(review.support)
      expect(response.body).to include(review.support_star.to_s)
      expect(response.body).to include(review.teacher)
      expect(response.body).to include(review.teacher_star.to_s)
      expect(response.body).to include(review.compatibility)
      expect(response.body).to include(review.compatibility_star.to_s)
      expect(response.body).to include(review.thought)
    end

  end

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

  describe "#edit" do
    context "as an authenticated user" do
      before do
        sign_in user
        get edit_review_path(review)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

end

    #   it "exists a correct page" do
    #     expect(response.body).to include("口コミ投稿")
    #     expect(response.body).to include(user.id.to_s)
    #   end

    # context "as a guest" do
    #   before do
    #     get new_review_path
    #   end

    #   it "redirect to login page" do
    #     expect(response).to redirect_to new_user_session_path
    #   end
    # end
