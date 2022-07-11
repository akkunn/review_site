class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @user_school = @user.user_schools.new
  end

  def update
    @user = User.find(params[:id])
    # @user.update(user_params)
    if @user.update(user_params)
      if @user.user_schools.first.nil?
        # binding.pry
        @user_school = UserSchool.create(user_id: params[:user][:user_school][:user_id], school_id: params[:user][:user_school][:school_id])
      else
        @user_school = @user.user_schools.first.update(user_id: params[:user][:user_school][:user_id], school_id: params[:user][:user_school][:school_id])
      end
      redirect_to @user
    else
      render 'users/edit'
    end

    # @user.user_schools.first.update(user_school_params)
    # if @user.update(user_params)
    #   redirect_to @user
    # else
    #   render 'users/edit'
    # end
  end
  # @user = User.new(user_params)
  # @user_school = @user.user_schools.build(user_school_params)
  # @user_school = UserSchool.new(user_params.merge(user_id: params[:user][:user_school][:school_id], school_id: params[:user][:user_school][:school_id]))

  private

  def user_params
    params.require(:user).permit(:name, :introduction, user_school_attributes: [:user_id, :school_id, :_destroy, :id])
  end

  # def user_school_params
  #   params.require(:user).permit(:name, :introduction, user_school: [:user_id, :school_id, :_destroy, :id])
  # end
end
