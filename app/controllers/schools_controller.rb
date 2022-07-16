class SchoolsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]

  def index
    @params = params[:signal]
    if @params == "review-count"
      @schools_first_group = School.limit(30)
      @schools_second_group = School.limit(30).offset(30)
    else
      @schools_first_group = School.limit(30).offset(30)
      @schools_second_group = School.limit(30)
    end
    # @schools_first_group = School.limit(30)
    # @schools_second_group = School.limit(30).offset(30)
    # @schools = [ @schools_first_group, @schools_second_group ]
    # binding.pry
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
            :language_id, :prefecture_id, :cost_id, :period_id)
  end
end
