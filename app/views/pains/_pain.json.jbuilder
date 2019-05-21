# frozen_string_literal: true

json.extract! pain,
              :id,
              :name,
              :created_at,
              :updated_at

json.url pain_url(pain, format: :json)
