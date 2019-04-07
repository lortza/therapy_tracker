# frozen_string_literal: true

json.extract! body_part, :id, :name, :created_at, :updated_at
json.url body_part_url(body_part, format: :json)
