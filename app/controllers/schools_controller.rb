class SchoolsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]

  def index
    @params = params[:signal]
    if @params == "review-count"
      @schools = School.paginate(page: params[:page]).order(review_count: :desc,
                                                            review_ave_score: :desc)
    elsif @params == "review-score"
      @schools = School.paginate(page: params[:page]).order(review_ave_score: :desc,
                                                            review_count: :desc)
    elsif @params == "new"
      @schools = School.paginate(page: params[:page]).order(id: :desc)
    else
      @schools = School.paginate(page: params[:page])
    end
  end

  def show
    @school = School.find(params[:id])
    @reviews = Review.where(school_id: @school.id)
  end

  def new
    @params = params[:school_index_params]
    @school = School.new
  end

  def create
    @school = School.new(school_params)
    if @school.save
      redirect_to schools_path(signal: "new")
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
      redirect_to school_path(@school)
    else
      render "edit"
    end
  end

  private

  def school_params
    params.require(:school).
      permit(:name, :style, :support, :guarantee, :explanation,
            :language_id, :prefecture_id, :cost_id, :period_id,
            :review_ave_score, :review_count, :image, :url)
  end
end
