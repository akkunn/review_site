class School < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :language
  belongs_to :cost
  belongs_to :period

  has_many :user_schools, dependent: :destroy
  has_many :users, through: :user_schools

  validates :name, presence: true, uniqueness: true
end
