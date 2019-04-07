# frozen_string_literal: true

class RemoveExerciseNameFromExerciseLogs < ActiveRecord::Migration[5.2]
  def up
    remove_column :exercise_logs, :exercise_name
  end

  def down
    add_column :exercise_logs, :exercise_name, :string, default: ''
  end
end
