# frozen_string_literal: true

class CreateLogEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :log_entries do |t|
      t.text :target_body_part, default: ""
      t.integer :sets, default: 0
      t.integer :reps, default: 0
      t.string :exercise_name, default: ""
      t.datetime :datetime_exercised
      t.integer :current_pain_level, default: 0
      t.string :current_pain_frequency, default: ""
      t.text :progress_note, default: ""

      t.timestamps
    end
  end
end
