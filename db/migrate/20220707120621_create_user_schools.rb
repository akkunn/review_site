class CreateUserSchools < ActiveRecord::Migration[6.1]
  def change
    create_table :user_schools do |t|
      t.integer :user_id
      t.integer :school_id

      t.timestamps
    end
  end
end
