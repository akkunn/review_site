class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @params = params[:review_show_params]
    @review = Review.find(params[:id])
  end

  def new
    unless params[:school_id].nil?
      @school = School.find(params[:school_id])
    end
    @params = params[:review_new_params]
    @review = Review.new
  end

  def create
    id = params[:review][:school_id]
    @review = Review.new(review_params)
    ave = ave_star(@review)
    @review.average_star = ave
    if @review.save
      @school = School.find(id)
      all_reviews_ave_score = all_reviews_ave_star(@school)
      @school.review_ave_score = all_reviews_ave_score
      @school.review_count = @school.reviews.count
      @school.save
      flash[:success] = "口コミを投稿しました"
      redirect_to school_path(@school, school_show_params: "review_create")
    else
      flash.now[:failure] = "口コミを投稿できませんでした"
      render "new"
    end
  end

  def edit
    @params = params[:review_edit_params]
    @review = Review.find(params[:id])
    unless current_user?(@review.user)
      flash[:failure] = "自分の口コミしか編集できません"
      redirect_to review_path(@review)
    end
  end

  def update
    id = params[:review][:school_id]
    @review = Review.find(params[:id])
    if current_user?(@review.user)
      if @review.update(review_params)
        ave = ave_star(@review)
        @review.average_star = ave
        if @review.save
          @school = School.find(id)
          all_reviews_ave_score = all_reviews_ave_star(@school)
          @school.review_ave_score = all_reviews_ave_score
          @school.review_count = @school.reviews.count
          @school.save
          flash[:success] = "口コミを変更しました"
          redirect_to review_path(@review)
        else
          @review.school = School.find(params[:hidden_school_id])
          flash.now[:failure] = "口コミを変更できませんでした"
          render "edit"
        end
      else
        @review.school = School.find(params[:hidden_school_id])
        flash.now[:failure] = "口コミを変更できませんでした"
        render "edit"
      end
    else
      flash[:failure] = "自分の口コミしか変更できません"
      redirect_to review_path(@review)
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if current_user?(@review.user)
      if @review.destroy
        flash[:success] = "口コミを削除しました"
        redirect_to school_path(@review.school)
      else
        flash.now[:failure] = "口コミを削除できませんでした"
        render "edit"
      end
    else
      flash[:failure] = "他のユーザーの口コミは削除できません"
      redirect_to review_path(@review)
    end
  end

  private

  def review_params
    params.require(:review).
      permit(:name, :curriculum, :support, :teacher, :compatibility,
              :thought, :user_id, :school_id, :curriculum_star,
              :support_star, :teacher_star, :compatibility_star, :average_star)
  end
end
