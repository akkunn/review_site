class FavoriteReviewsController < ApplicationController
  before_action :review_params, except: [:guest_favorite_review]

  def create
    FavoriteReview.create(user_id: current_user.id, review_id: params[:id])
  end

  def destroy
    FavoriteReview.find_by(user_id: current_user.id, review_id: params[:id]).destroy
  end

  def guest_favorite_review
    flash[:failure] = "「いいね」はログインしないとできません"
    redirect_to new_user_session_path
  end

  private

  def review_params
    @review = Review.find(params[:id])
  end
end
