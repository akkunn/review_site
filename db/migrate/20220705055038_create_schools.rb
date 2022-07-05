class CreateSchools < ActiveRecord::Migration[6.1]
  def change
    create_table :schools do |t|
      t.string :name, null: false
      t.string :style
      t.string :support
      t.string :guarantee
      t.text :feature
      t.integer :language_id
      t.integer :prefecture_id
      t.integer :cost_id
      t.integer :period_id

      t.timestamps
    end
  end
end
