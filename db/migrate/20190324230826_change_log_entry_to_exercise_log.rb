# frozen_string_literal: true

class ChangeLogEntryToExerciseLog < ActiveRecord::Migration[5.2]
  def self.up
    rename_table :log_entries, :exercise_logs
    rename_column :exercise_logs, :datetime_exercised, :datetime_occurred
  end

  def self.down
    rename_table :exercise_logs, :log_entries
    rename_column :log_entries, :datetime_occurred, :datetime_exercised
  end
end
