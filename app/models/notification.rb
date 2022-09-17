class Notification < ApplicationRecord
  scope :order_new, -> { order(created_at: :desc) }
  belongs_to :review, optional: true
  belongs_to :answer, optional: true
  belongs_to :question, optional: true
  belongs_to :visiter, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true

  def how_long_ago
    if (Time.now.to_s(:date_jp).to_i - created_at.to_s(:date_jp).to_i) == 0
      '今日'
    else
      "#{(Time.now.to_s(:date_jp).to_i - created_at.to_s(:date_jp).to_i)}日前"
    end
  end
end
