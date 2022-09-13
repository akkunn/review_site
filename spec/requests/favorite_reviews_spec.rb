require 'rails_helper'

RSpec.describe "FavoriteReviews", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:school) { FactoryBot.create(:school) }
  let(:review) { FactoryBot.create(:review, user_id: user.id, school_id: school.id) }
  let(:favorite_review_params) {
    FactoryBot.attributes_for(:favorite_review, user_id: user.id, review_id: review.id)
  }

  describe "#create" do
    context "as an authenticated user" do
      it "likes a review" do
        sign_in user
        expect {
          post create_favorite_review_path(review),
               params: { favorite_review: favorite_review_params }, xhr: true
        }.to change { FavoriteReview.count }.by(1)
      end
    end

    context "as a guest" do
      it "doesn't like a review" do
        expect {
          post create_favorite_review_path(review),
               params: { favorite_review: favorite_review_params }, xhr: true
        }.not_to change { FavoriteReview.count }
      end

      it "redirects to login page" do
        post create_favorite_review_path(review),
             params: { favorite_review: favorite_review_params }, xhr: true
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#destroy" do
    before do
      FactoryBot.create(:favorite_review, user_id: user.id, review_id: review.id)
    end

    context "as an authorized user" do
      it "deletes a favorite_review" do
        sign_in user
        expect {
          delete destroy_favorite_review_path(review), xhr: true
        }.to change { FavoriteReview.count }.by(-1)
      end
    end

    context "as a guest" do
      it "doesn't delete a favorite_review" do
        expect {
          delete destroy_favorite_review_path(review), xhr: true
        }.not_to change { FavoriteReview.count }
      end

      it "redirects to login page" do
        delete destroy_favorite_review_path(review), xhr: true
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
