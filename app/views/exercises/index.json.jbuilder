# frozen_string_literal: true

json.array! @exercises, partial: "exercises/exercise", as: :exercise
