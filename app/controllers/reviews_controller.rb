class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @reviews = Review.all
  end

  def show
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to reviews_path
    else
      render "new"
    end
  end

  private

  def review_params
    params.require(:review).
      permit(:name, :curriculum, :support, :teacher, :compatibility, :thought, :user_id, :school_id, :curriculum_star, :support_star, :teacher_star, :compatibility_star)
  end
end
