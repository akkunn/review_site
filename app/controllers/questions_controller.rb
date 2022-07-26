class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @questions = Question.where(school_id: params[:school_id]).order(updated_at: :desc)
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if current_user?(@question.user)
      if @question.save
        flash[:success] = "質問を作成しました"
        redirect_to questions_path(school_id: @question.school_id)
      else
        flash[:danger] = "質問を作成できませんでした"
        render "new"
      end
    else
      flash[:danger] = "質問を作成できませんでした"
      redirect_to new_question_path
    end
  end

  def edit
    @question = Question.find(params[:id])
    unless current_user?(@question.user)
      redirect_to question_path(@question)
    end
  end

  def update
    @question = Question.find(params[:id])
    if current_user?(@question.user)
      if @question.update(question_params)
        flash[:success] = "質問を変更しました"
        redirect_to questions_path(school_id: @question.school_id)
      else
        flash[:danger] = "質問を変更できませんでした"
        render "edit"
      end
    else
      flash[:danger] = "質問を変更できませんでした"
      redirect_to question_path(@question)
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question_shcool_id = @question.school_id
    if @question.destroy
    flash[:success] = "質問を削除しました"
    redirect_to questions_path(school_id: @question_shcool_id)
    else
      flash[:danger] = "質問を削除できませんでした"
      render "show"
    end
  end

  private

  def question_params
    params.require(:question).permit(:name, :content, :user_id, :school_id)
  end
end
