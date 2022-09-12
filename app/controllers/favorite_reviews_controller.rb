class FavoriteReviewsController < ApplicationController
  def create
    FavoriteReview.create(user_id: current_user.id, review_id: params[:id])
    redirect_to root_path
  end

  def destroy
    FavoriteReview.find_by(user_id: current_user.id, review_id: params[:id]).destroy
    redirect_to root_path
  end
end
