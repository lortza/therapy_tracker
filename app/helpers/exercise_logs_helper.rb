module ExerciseLogsHelper
  def format_time(log)
    # log.datetime_occurred.strftime("%a %m/%d/%y at %I:%M %p in %Z")
    log.datetime_occurred.strftime("%a %m/%d/%y at %I:%M%p")
  end

  def format_exercise(log)
    "#{log.exercise_name.titleize}: #{log.sets} sets / #{log.reps} reps"
  end
end
