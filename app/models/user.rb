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
  has_many :answers, dependent: :destroy
  has_many :favorite_reviews, dependent: :destroy
  has_many :favorite_items, through: :favorite_reviews, source: :review
  has_one_attached :image
  accepts_nested_attributes_for :user_schools, allow_destroy: true
  validates :name, presence: true

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now
      user.name = "ゲスト"
    end
  end

  def liked_by?(review_id)
    FavoriteReview.where(review_id: review_id).exists?
  end
end
