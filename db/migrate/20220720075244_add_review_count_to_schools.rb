class AddReviewCountToSchools < ActiveRecord::Migration[6.1]
  def change
    add_column :schools, :review_count, :integer
  end
end
