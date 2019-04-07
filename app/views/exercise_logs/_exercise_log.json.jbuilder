# frozen_string_literal: true

json.extract! exercise_log, :id, :sets, :reps, :exercise_id, :datetime_occurred, :current_pain_level, :current_pain_frequency, :progress_note, :created_at, :updated_at
json.url exercise_log_url(exercise_log, format: :json)
