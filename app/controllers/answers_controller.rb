class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def create
    @answer = Answer.new(answer_params)
    if current_user?(@answer.user)
      if @answer.save
        flash[:success] = "回答を投稿しました"
        redirect_to question_path(@answer.question)
      else
        @question = @answer.question
        @answers = Answer.where(question_id: @question.id)
        flash[:failure] = "回答を投稿できませんでした"
        render "questions/show"
      end
    else
      flash[:failure] = "他のユーザーで回答は投稿できません"
      redirect_to question_path(@answer.question)
    end
  end

  def edit
    if current_user.nil?
      redirect_to new_user_session_path
    else
      @answer = Answer.find(params[:id])
      unless current_user?(@answer.user)
        redirect_to question_path(@answer.question)
      end
    end
  end

  def update
    @answer = Answer.find(params[:id])
    if current_user?(@answer.user)
      if @answer.update(answer_params)
        flash[:success] = "回答を変更しました"
        redirect_to question_path(@answer.question)
      else
        flash[:failure] = "回答を変更できませんでした"
        render "questions/show"
      end
    else
      flash[:failure] = "回答を変更できませんでした"
      redirect_to question_path(@answer.question)
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if current_user?(@answer.user)
      if @answer.destroy
        flash[:success] = "回答を削除しました"
        redirect_to question_path(@answer.question)
      else
        flash[:failure] = "回答を削除できませんでした"
        render "questions/show"
      end
    else
      flash[:failure] = "他のユーザーの回答は削除できません"
      redirect_to question_path(@answer.question)
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :user_id, :question_id)
  end
end
