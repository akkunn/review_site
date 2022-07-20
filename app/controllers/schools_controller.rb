class SchoolsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]

  def index
    @params = params[:signal]
    if @params == "review-count"
      @schools_first_group = School.order(review_count: :desc, review_ave_score: :desc).limit(30)
      @schools_second_group = School.order(review_count: :desc, review_ave_score: :desc).limit(30).offset(30)
    elsif @params == "review-rating"
      @schools_first_group = School.order(review_ave_score: :desc, review_count: :desc).limit(30)
      @schools_second_group = School.order(review_ave_score: :desc, review_count: :desc).limit(30).offset(30)
    else
      @schools_first_group = School.limit(30)
      @schools_second_group = School.limit(30).offset(30)
    end
  end

  def show
    @school = School.find(params[:id])
    @reviews = Review.where(school_id: @school.id)

  end

  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)
    if @school.save
      redirect_to schools_path
    else
      render "new"
    end
  end

  def edit
    @school = School.find(params[:id])
  end

  def update
    @school = School.find(params[:id])
    if @school.update(school_params)
      redirect_to schools_path
    else
      render "edit"
    end
  end

  private

  def school_params
    params.require(:school).
      permit(:name, :style, :support, :guarantee, :explanation,
            :language_id, :prefecture_id, :cost_id, :period_id, :review_ave_score, :review_count)
  end
end
