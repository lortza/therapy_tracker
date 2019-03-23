json.extract! log_entry, :id, :sets, :reps, :exercise_name, :datetime_exercised, :current_pain_level, :current_pain_frequency, :progress_note, :created_at, :updated_at
json.url log_entry_url(log_entry, format: :json)
