class NotificationsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :destroy, :destroy_all]

  def index
    @notifications = current_user.passive_notifications.paginate(page: params[:page]).per(30)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    if current_user?(@notification.visited)
      if @notification.destroy
        flash[:success] = "通知を削除しました"
        redirect_to notifications_path
      else
        flash.now[:failure] = "通知を削除できませんでした"
        render "index"
      end
    else
      flash[:failure] = "他のユーザーの通知は削除できません"
      redirect_to notifications_path
    end
  end

  def destroy_all
    @user = User.find(params[:user_id])
    if current_user?(@user)
      if current_user.passive_notifications.destroy_all
        flash[:success] = "通知を全て削除しました"
        redirect_to notifications_path
      else
        flash.now[:failure] = "通知を削除できませんでした"
        render "index"
      end
    else
      flash[:failure] = "他のユーザーの通知は削除できません"
      redirect_to notifications_path
    end
  end
end
