module ExerciseLogsHelper
  def format_exercise_stats(log)
    "#{log.sets} sets / #{log.reps} reps at #{log.rep_length} seconds each"
  end
end
