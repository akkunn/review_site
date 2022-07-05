class School < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :language
  belongs_to :cost
  belongs_to :period

  validates :name, presence: true, uniqueness: true
end
