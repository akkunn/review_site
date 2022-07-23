class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if current_user?(@question.user)
      if @question.save
        redirect_to questions_path
      else
        render "new"
      end
    else
      redirect_to new_question_path
    end
  end

  def edit
  end

  private

  def question_params
    params.require(:question).permit(:name, :content, :user_id, :school_id)
  end
end
