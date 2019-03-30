module ExerciseLogsHelper
  def format_exercise(log)
    "#{log.exercise_name.titleize}: #{log.sets} sets / #{log.reps} reps at #{log.rep_length} seconds each"
  end
end
