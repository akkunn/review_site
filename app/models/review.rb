class Review < ApplicationRecord
  belongs_to :school
  belongs_to :user

  validates :name, presence: true, length: { maximum: 60 }
  validates :thought, presence: true
  validates :user_id, presence: true
end
