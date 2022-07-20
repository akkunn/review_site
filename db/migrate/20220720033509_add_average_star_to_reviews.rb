class AddAverageStarToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :average_star, :float
  end
end
