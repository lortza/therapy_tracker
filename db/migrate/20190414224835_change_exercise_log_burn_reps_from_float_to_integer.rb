class ChangeExerciseLogBurnRepsFromFloatToInteger < ActiveRecord::Migration[5.2]
  def up
    change_column :exercise_logs, :burn_rep, :integer
  end

  def down
    change_column :exercise_logs, :burn_rep, :float
  end
end
