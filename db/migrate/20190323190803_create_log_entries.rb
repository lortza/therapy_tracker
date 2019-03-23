class CreateLogEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :log_entries do |t|
      t.integer :sets
      t.integer :reps
      t.string :exercise_name
      t.datetime :datetime_exercised
      t.integer :current_pain_level
      t.string :current_pain_frequency
      t.text :progress_note

      t.timestamps
    end
  end
end
