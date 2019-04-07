# frozen_string_literal: true

json.extract! exercise, :id, :user_id, :name, :description, :created_at, :updated_at
json.url exercise_url(exercise, format: :json)
