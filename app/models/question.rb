class Question < ApplicationRecord
  belongs_to :user
  belongs_to :school
  has_many :answers, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :name, presence: true, length: { maximum: 60 }
  validates :content, presence: true
  validates :user_id, presence: true
end
