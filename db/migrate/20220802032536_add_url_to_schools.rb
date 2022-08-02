class AddUrlToSchools < ActiveRecord::Migration[6.1]
  def change
    add_column :schools, :url, :text
  end
end
