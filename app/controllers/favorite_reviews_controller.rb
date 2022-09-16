class FavoriteReviewsController < ApplicationController
  before_action :review_params, except: [:guest_favorite_review]

  def create
    if user_signed_in?
      FavoriteReview.create(user_id: current_user.id, review_id: params[:id])
      review = Review.find(params[:id])
      review.create_notification_like!(current_user)
    else
      flash[:failure] = "「いいね」はログインしないとできません"
      redirect_to new_user_session_path
    end
  end

  def destroy
    if user_signed_in?
      FavoriteReview.find_by(user_id: current_user.id, review_id: params[:id]).destroy
    else
      flash[:failure] = "「いいね」を解除するにはログインしてください"
      redirect_to new_user_session_path
    end
  end

  private

  def review_params
    @review = Review.find(params[:id])
  end
end
