require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let!(:review) { FactoryBot.create(:review, user_id: user.id, school_id: school.id) }
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:school) { FactoryBot.create(:school) }
  let(:review_params) { FactoryBot.attributes_for(:review, user_id: user.id, school_id: school.id) }
  let(:update_review_params) {
    FactoryBot.attributes_for(:review, user_id: user.id, school_id: school.id, curriculum_star: 5)
  }

  describe "#show" do
    context "as an authenticated user" do
      before do
        sign_in user
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
        expect(response.body).to include("編集する")
      end
    end

    context "as a guest" do
      before do
        get review_path(review)
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
        expect(response.body).not_to include("編集する")
      end
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

      it "redirects to login page" do
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

      it "redirects to login page" do
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

      it "exists a correct page" do
        expect(response.body).to include("口コミ編集")
        expect(response.body).to include(school.name)
        expect(response.body).to include(review.name)
        expect(response.body).to include(review.curriculum)
        expect(response.body).to include(review.support)
        expect(response.body).to include(review.teacher)
        expect(response.body).to include(review.compatibility)
        expect(response.body).to include(review.thought)
        expect(response.body).to include("削除する")
      end
    end

    context "as an unauthorized user" do
      before do
        sign_in other_user
        get edit_review_path(review)
      end

      it "redirects review show page" do
        expect(response).to redirect_to review_path(review)
      end
    end

    context "as a guest" do
      it "redirects to login page" do
        get edit_review_path(review)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#update" do
    context "as an authorized user" do
      before do
        sign_in user
      end

      it "updates a review" do
        patch review_path(review), params: { review: update_review_params }
        expect(review.reload.average_star).to eq 4
      end
    end

    context "as an unauthorized user" do
      before do
        sign_in other_user
        patch review_path(review), params: { review: update_review_params }
      end

      it "doesn't update a review" do
        expect(review.reload.average_star).to eq 3.5
      end

      it "redirects review show page" do
        expect(response).to redirect_to review_path(review)
      end
    end

    context "as a guest" do
      before do
        patch review_path(review), params: { review: update_review_params }
      end

      it "doesn't update a review" do
        expect(review.reload.average_star).to eq 3.5
      end

      it "redirect to login page" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#destroy" do
    context "as an authorized user" do
      it "deletes a review" do
        sign_in user
        expect {
          delete review_path(review)
        }.to change { Review.count }.by(-1)
      end
    end

    context "as an unauthorized user" do
      before do
        sign_in other_user
      end

      it "doesn't delete a review" do
        expect {
          delete review_path(review)
        }.not_to change { Review.count }
      end

      it "redirects to review show page" do
        delete review_path(review)
        expect(response).to redirect_to review_path(review)
      end
    end

    context "as a guest" do
      before do
        delete review_path(review)
      end

      it "doesn't delete a review" do
        expect {
          delete review_path(review)
        }.not_to change { Review.count }
      end

      it "redirects to login page" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
