class RenameFeatureColumnToSchools < ActiveRecord::Migration[6.1]
  def change
    rename_column :schools, :feature, :explanation
  end
end

