# frozen_string_literal: true

json.extract! pt_session,
              :id,
              :user_id,
              :datetime_occurred,
              :exercise_notes,
              :homework,
              :duration,
              :created_at,
              :updated_at

json.url pt_session_url(pt_session, format: :json)
