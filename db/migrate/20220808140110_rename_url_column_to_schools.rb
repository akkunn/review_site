class RenameUrlColumnToSchools < ActiveRecord::Migration[6.1]
  def change
    rename_column :schools, :url, :site_address
  end
end
