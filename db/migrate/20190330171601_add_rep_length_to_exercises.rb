class AddRepLengthToExercises < ActiveRecord::Migration[5.2]
  def up
    add_column :exercise_logs, :rep_length, :integer, default: 0
    remove_column :exercise_logs, :current_pain_frequency
    remove_column :exercise_logs, :current_pain_level
  end

  def down
    remove_column :exercise_logs, :rep_length
    add_column :exercise_logs, :current_pain_frequency, :integer, default: 0
    add_column :exercise_logs, :current_pain_level, :integer, default: 0
  end
end
