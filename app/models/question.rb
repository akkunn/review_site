class Question < ApplicationRecord
  belongs_to :user
  belongs_to :school

  validates :name, presence: true
  validates :content, presence: true
  validates :user_id, presence: true
  validates :school_id, presence: true
end
