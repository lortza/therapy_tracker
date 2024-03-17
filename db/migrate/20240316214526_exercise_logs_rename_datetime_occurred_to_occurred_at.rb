class ExerciseLogsRenameDatetimeOccurredToOccurredAt < ActiveRecord::Migration[7.0]
  def up
    rename_column :exercise_logs, :datetime_occurred, :occurred_at
  end

  def down
    rename_column :exercise_logs, :occurred_at, :datetime_occurred
  end
end
