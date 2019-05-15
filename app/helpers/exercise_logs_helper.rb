# frozen_string_literal: true

module ExerciseLogsHelper
  def format_exercise_stats(log)
    per_side = log.per_side ? 'each per leg' : 'each'
    "#{log.sets} sets / #{log.reps} reps at #{log.rep_length} seconds #{per_side}"
  end

  def format_resistance(log)
    unless log.resistance.blank?
      " | Resistance: #{log.resistance}. "
    end
  end

  def destination_url(pt_session)
    pt_session ? pt_session_exercise_log_path(pt_session, @exercise_log) : exercise_log_path(@exercise_log)
  end
end
