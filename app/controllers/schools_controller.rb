class SchoolsController < ApplicationController
  def index
    @schools = School.all
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
  end

  private

  def school_params
    params.require(:school).
      permit(:name, :style, :support, :guarantee, :explanation,
            :language_id, :prefecture_id, :cost_id, :period_id)
  end
end
