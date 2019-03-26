json.extract! physical_therapy_session, :id, :user_id, :datetime_occurred, :exercise_notes, :homework, :duration, :created_at, :updated_at
json.url physical_therapy_session_url(physical_therapy_session, format: :json)
