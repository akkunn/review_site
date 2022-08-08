class AddIndexToSchoolsName < ActiveRecord::Migration[6.1]
  def change
    add_index :schools, :name, unique: true
  end
end
