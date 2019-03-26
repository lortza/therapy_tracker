json.extract! pain_log, :id, :user_id, :datetime_occurred, :target_body_part, :pain_level, :pain_description, :trigger, :created_at, :updated_at
json.url pain_log_url(pain_log, format: :json)
