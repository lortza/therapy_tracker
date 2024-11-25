# frozen_string_literal: true

json.array! @exercise_logs, partial: "exercise_logs/exercise_log", as: :exercise_log
