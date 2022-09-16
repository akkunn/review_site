class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :notifications, dependent: :destroy

  validates :content, presence: true
  validates :user_id, presence: true
  validates :question_id, presence: true
end
