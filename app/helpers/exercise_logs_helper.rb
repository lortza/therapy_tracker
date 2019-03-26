module ExerciseLogsHelper
  def format_exercise(log)
    "#{log.exercise_name.titleize}: #{log.sets} sets / #{log.reps} reps"
  end
end
