class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if current_user.id == @user.id
      @user_school = @user.user_schools.new
    else
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if current_user.id == @user.id
      if @user.update(user_params)
        if @user.user_schools.first.nil?
          @user_school = UserSchool.
            create(user_id: params[:user][:user_school][:user_id],
                   school_id: params[:user][:user_school][:school_id])
        else
          @user_school = @user.user_schools.first.
            update(user_id: params[:user][:user_school][:user_id],
                   school_id: params[:user][:user_school][:school_id])
        end
        flash[:success] = "プロフィールを変更しました"
        redirect_to @user
      else
        flash.now[:failure] = "プロフィールを変更できませんでした"
        render 'users/edit'
      end
    else
      flash[:failure] = "自分のプロフィールしか変更できません"
      redirect_to @user
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,
                                  :image,
                                  :introduction,
                                  user_school_attributes: [:user_id, :school_id, :_destroy, :id])
  end
end
