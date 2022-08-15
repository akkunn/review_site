class UserSchoolsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def destroy
    @user_school = UserSchool.find(params[:id])
    if current_user?(@user_school.user)
      if @user_school.destroy
        flash[:success] = "スクール名を削除しました"
        redirect_to edit_user_path(@user_school.user)
      else
        flash.now[:failure] = "スクール名を削除できませんでした"
        render "edit"
      end
    else
      flash[:failure] = "他のユーザーのスクール名は削除できません"
      redirect_to user_path(@user_school.user)
    end
  end
end
