class AddSolutionToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :solution, :integer, null: false, default: 0
  end
end
