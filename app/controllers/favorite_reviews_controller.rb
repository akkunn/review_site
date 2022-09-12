class FavoriteReviewsController < ApplicationController
  before_action :review_params

  def create
    FavoriteReview.create(user_id: current_user.id, review_id: params[:id])
  end

  def destroy
    FavoriteReview.find_by(user_id: current_user.id, review_id: params[:id]).destroy
  end

  private

  def review_params
    @review = Review.find(params[:id])
  end
end
