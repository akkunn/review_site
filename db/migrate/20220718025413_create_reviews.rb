class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :name, null: false
      t.text :curriculum
      t.text :support
      t.text :teacher
      t.text :compatibility
      t.text :thought
      t.integer :user_id
      t.integer :school_id
      t.float :curriculum_star
      t.float :support_star
      t.float :teacher_star
      t.float :compatibility_star

      t.timestamps
    end
  end
end
