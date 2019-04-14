class AddBurnSetToExerciseLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :exercise_logs, :burn_set, :integer
  end
end
