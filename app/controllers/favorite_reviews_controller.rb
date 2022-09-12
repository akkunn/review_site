class FavoriteReviewsController < ApplicationController
  def create
    Favorite_review.create(user_id: current_user.id, review_id: params[:id])
    redirect_to root_path
  end
end
