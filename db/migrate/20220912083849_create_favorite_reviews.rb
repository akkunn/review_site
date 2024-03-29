class CreateFavoriteReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true

      t.timestamps
      t.index [:user_id, :review_id], unique: true
    end
  end
end
