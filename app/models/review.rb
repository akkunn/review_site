class Review < ApplicationRecord
  belongs_to :school
  belongs_to :user
  has_many :favorite_reviews, dependent: :destroy
  has_many :favorite_users, through: :favorite_reviews, source: :user

  validates :name, presence: true, length: { maximum: 60 }
  validates :thought, presence: true
  validates :user_id, presence: true
end
