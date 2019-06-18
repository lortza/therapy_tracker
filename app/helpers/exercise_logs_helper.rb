# frozen_string_literal: true

module ExerciseLogsHelper
  def format_exercise_stats(log)
    per_side = log.per_side ? 'each per side' : 'each'
    "#{log.sets} sets / #{log.reps} reps at #{log.rep_length} seconds #{per_side}"
  end

  def format_resistance(log)
    " | Resistance: #{log.resistance}. " if log.resistance.present?
  end

  def destination_url(exercise_log, pt_session_log = nil)
    pt_session_log ? pt_session_log_exercise_log_path(pt_session_log, exercise_log) : exercise_log_path(exercise_log)
  end

  def new_exercise_log_button(pt_session_log)
    if pt_session_log
      link_to '<i class="fal fa-hospital-user"></i> Log Another PT Exercise'.html_safe,
              new_pt_session_log_exercise_log_path(pt_session_log),
              class: 'btn btn-outline btn-wide btn-info'
    else
      link_to '<i class="fal fa-dumbbell"></i> Log Another Exercise'.html_safe,
              new_exercise_log_path,
              class: 'btn btn-outline btn-wide btn-success'
    end
  end
end
