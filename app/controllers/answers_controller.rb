class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @answer = Answer.new(answer_params)
    if current_user?(@answer.user)
      if @answer.save
        flash[:success] = "回答を投稿しました"
        redirect_to question_path(@answer.question)
      else
        flash[:failure] = "回答を投稿できませんでした"
        render "questions/show"
      end
    else
      flash[:failure] = "他のユーザーで回答は投稿できません"
      redirect_to question_path(@answer.question)
    end
  end

  def edit
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :user_id, :question_id)
  end
end
