# frozen_string_literal: true

json.extract! pt_session_log,
  :id,
  :user_id,
  :occurred_at,
  :exercise_notes,
  :homework,
  :duration,
  :created_at,
  :updated_at

json.url pt_session_log_url(pt_session_log, format: :json)
