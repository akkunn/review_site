class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :review, optional: true
  belongs_to :answer, optional: true
  belongs_to :question, optional: true
  belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

  def how_long_ago
    if (Time.now.to_s(:date_jp).to_i - self.created_at.to_s(:date_jp).to_i) == 0
      '今日'
    else
      "#{(Time.now.to_s(:date_jp).to_i - self.created_at.to_s(:date_jp).to_i)}日前"
    end
  end
end
