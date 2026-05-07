class AddInstructionsToSurveys < ActiveRecord::Migration[8.1]
  def change
    add_column :surveys, :instructions, :text
  end
end
