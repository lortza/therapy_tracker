# frozen_string_literal: true

json.array! @body_parts, partial: "body_parts/body_part", as: :body_part
