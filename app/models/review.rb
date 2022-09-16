class Review < ApplicationRecord
  belongs_to :school
  belongs_to :user
  has_many :favorite_reviews, dependent: :destroy
  has_many :favorite_users, through: :favorite_reviews, source: :user
  has_many :notifications, dependent: :destroy

  validates :name, presence: true, length: { maximum: 60 }
  validates :thought, presence: true
  validates :user_id, presence: true

  def create_notification_like!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and review_id = ? and action = ?", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        review_id: id,
        visited_id: user_id,
        action: 'like'
      )
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
