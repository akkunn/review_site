class Review < ApplicationRecord
  belongs_to :school
  belongs_to :user

  validates :name, presence: true
  validates :thought, presence: true
  validates :user_id, presence: true
  validates :school_id, presence: true
end
