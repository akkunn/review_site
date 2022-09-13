class FavoriteReviewsController < ApplicationController
  before_action :review_params, except: [:guest_favorite_review]

  def create
    if user_signed_in?
      FavoriteReview.create(user_id: current_user.id, review_id: params[:id])
    else
      flash[:failure] = "「いいね」はログインしないとできません"
      redirect_to new_user_session_path
    end
  end

  def destroy
    FavoriteReview.find_by(user_id: current_user.id, review_id: params[:id]).destroy
  end

  private

  def review_params
    @review = Review.find(params[:id])
  end
end
