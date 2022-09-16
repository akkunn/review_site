class Question < ApplicationRecord
  belongs_to :user
  belongs_to :school
  has_many :answers, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :name, presence: true, length: { maximum: 60 }
  validates :content, presence: true
  validates :user_id, presence: true

  def create_notification_answer!(current_user, answer_id)
    notification = current_user.active_notifications.new(
      question_id: id,
      answer_id: answer_id,
      visited_id: user_id,
      action: 'answer'
    )
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
