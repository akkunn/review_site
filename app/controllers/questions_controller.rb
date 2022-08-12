class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @params = params[:question_index_params]
    @school = School.find(params[:school_id])
    @questions = Question.where(school_id: @school.id).order(updated_at: :desc)
  end

  def show
    if Question.exists?(params[:id])
      @params = params[:question_show_params]
      @question = Question.find(params[:id])
      @answers = Answer.where(question_id: @question.id)
      @answer = Answer.new
    else
      flash[:failure] = "質問は削除されています"
      redirect_to root_path
    end
  end

  def new
    @school = School.find(params[:school_id])
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if current_user?(@question.user)
      if @question.save
        flash[:success] = "質問を投稿しました"
        redirect_to questions_path(school_id: @question.school_id)
      else
        @school = School.find(params[:school_id])
        flash.now[:failure] = "質問を投稿できませんでした"
        render "new"
      end
    else
      flash[:failure] = "他のユーザーで質問は投稿できません"
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
        flash.now[:failure] = "質問を変更できませんでした"
        render "edit"
      end
    else
      flash[:failure] = "他のユーザーの質問は変更できません"
      redirect_to question_path(@question)
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question_shcool_id = @question.school_id
    if current_user?(@question.user)
      if @question.destroy
        flash[:success] = "質問を削除しました"
        redirect_to questions_path(school_id: @question_shcool_id)
      else
        flash.now[:failure] = "質問を削除できませんでした"
        render "show"
      end
    else
      flash[:failure] = "他のユーザーの質問は削除できません"
      redirect_to question_path(@question)
    end
  end

  def solved
    @question = Question.find(params[:question_id])
    if current_user?(@question.user)
      if (@question.solution == 2) && (@question.answers.count == 0)
        @question.solution = 0
        if @question.save
          flash[:success] = "未回答に変更しました"
          redirect_to questions_path(school_id: @question.school_id)
        else
          flash.now[:failure] = "変更できませんでした"
          render "show"
        end
      elsif @question.solution == 0 || @question.solution == 1
        @question.solution = 2
        if @question.save
          flash[:success] = "解決済みに変更しました"
          redirect_to questions_path(school_id: @question.school_id)
        else
          flash.now[:failure] = "変更できませんでした"
          render "show"
        end
      else
        @question.solution = 1
        if @question.save
          flash[:success] = "未解決に変更しました"
          redirect_to questions_path(school_id: @question.school_id)
        else
          flash.now[:failure] = "変更できませんでした"
          render "show"
        end
      end
    else
      flash[:failure] = "他のユーザーの質問は変更できません"
      redirect_to question_path(@question)
    end
  end

  private

  def question_params
    params.require(:question).permit(:name, :content, :user_id, :school_id)
  end
end
