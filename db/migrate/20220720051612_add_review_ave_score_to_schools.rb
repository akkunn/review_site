class AddReviewAveScoreToSchools < ActiveRecord::Migration[6.1]
  def change
    add_column :schools, :review_ave_score, :float
  end
end
