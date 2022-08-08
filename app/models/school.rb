class School < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :language
  belongs_to :cost
  belongs_to :period
  has_one_attached :image

  has_many :user_schools, dependent: :destroy
  has_many :users, through: :user_schools
  has_many :reviews, dependent: :destroy
  has_many :questions, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :explanation, presence: true, length: {in: 1..300}
end
