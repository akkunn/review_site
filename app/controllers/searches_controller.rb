class SearchesController < ApplicationController
  # before_action :search_school, only: [:home, :result]

  def home
    @schools = School.all
    @reviews = Review.all
    @questions = Question.all
    set_style_column
    set_support_column
    set_guarantee_column
  end

  def result
    # binding.pry
    @schools = @q.result.paginate(page: params[:page])
    set_style_column
    set_support_column
    set_guarantee_column
  end

  private

  # def search_school
  #   @q = School.ransack(params[:q])
  # end

  # 重複なくカラムのデータを取り出す
  def set_style_column
    @school_style = School.select("style").distinct
  end

  def set_support_column
    @school_support = School.select("support").distinct
  end

  def set_guarantee_column
    @school_guarantee = School.select("guarantee").distinct
  end
end
