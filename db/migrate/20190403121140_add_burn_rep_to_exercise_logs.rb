# frozen_string_literal: true

class AddBurnRepToExerciseLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :exercise_logs, :burn_rep, :float
  end
end
