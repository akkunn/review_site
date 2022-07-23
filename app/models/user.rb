class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :user_schools, dependent: :destroy
  has_many :schools, through: :user_schools
  has_many :reviews, dependent: :destroy
  has_many :questions, dependent: :destroy

  accepts_nested_attributes_for :user_schools, allow_destroy: true

  validates :name, presence: true
end
