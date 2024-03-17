class AddIndexToExerciseLogsOccurredAt < ActiveRecord::Migration[7.0]
  def up
    add_index :exercise_logs, :occurred_at, if_not_exists: true
  end

  def down
    remove_index :exercise_logs, :occurred_at if index_exists?(:exercise_logs, :occurred_at)
  end
end
