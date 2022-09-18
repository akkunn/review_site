class Notification < ApplicationRecord
  scope :order_new, -> { order(created_at: :desc) }
  belongs_to :review, optional: true
  belongs_to :answer, optional: true
  belongs_to :question, optional: true
  belongs_to :visiter, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true

  def how_long_ago
    if (Time.current.to_s(:date_jp).to_i - created_at.to_s(:date_jp).to_i) == 0
      '今日'
    elsif (Time.current.to_s(:date_jp).to_i - created_at.to_s(:date_jp).to_i) >= 100
      '1ヶ月前'
    elsif (Time.current.to_s(:date_jp).to_i - created_at.to_s(:date_jp).to_i) >= 200
      created_at.to_s(:datetime_jp)
    else
      "#{(Time.current.to_s(:date_jp).to_i - created_at.to_s(:date_jp).to_i)}日前"
    end
  end
end
