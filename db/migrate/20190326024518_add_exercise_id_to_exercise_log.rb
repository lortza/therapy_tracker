# frozen_string_literal: true

class AddExerciseIdToExerciseLog < ActiveRecord::Migration[5.2]
  def change
    add_reference :exercise_logs, :exercise, foreign_key: true
  end
end
