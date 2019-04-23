# frozen_string_literal: true

module ExerciseLogsHelper
  def format_exercise_stats(log)
    per_side = log.per_side ? 'each per leg' : 'each'
    "#{log.sets} sets / #{log.reps} reps at #{log.rep_length} seconds #{per_side}"
  end

  def format_resistance(log)
    if log.resistance
      " Resistance: #{log.resistance}. "
    end
  end
end
