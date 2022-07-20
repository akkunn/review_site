class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    # binding.pry
    # @school = School.find(params[:id])
    # @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def create
    id = params[:review][:school_id]
    @school = School.find(id)
    @review = Review.new(review_params)
    ave = ave_star(@review)
    @review.average_star = ave
    if @review.save
      all_reviews_ave_score = all_reviews_ave_star(@school)
      @school.review_ave_score = all_reviews_ave_score
      @school.save
      redirect_to school_path(@school)
    else
      render "new"
    end
  end

  private

  def review_params
    params.require(:review).
      permit(:name, :curriculum, :support, :teacher, :compatibility, :thought, :user_id, :school_id, :curriculum_star, :support_star, :teacher_star, :compatibility_star, :average_star)
  end
end
