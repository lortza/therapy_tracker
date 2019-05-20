# frozen_string_literal: true

module LogsHelper
  def format_time(log)
    # log.datetime_occurred.strftime("%a %m/%d/%y at %I:%M %p in %Z")
    log.datetime_occurred.strftime('%a %m/%d/%y at %I:%M%p')
  end

  def last_log(kollection, attr)
    current_user.send(kollection)[-2]&.send(attr)
  end

  def last_homework
    return false if current_user.pt_sessions.last.nil?
    
    {
      notes: current_user.pt_sessions.last&.homework,
      exercises: current_user.pt_sessions.last&.homework_exercises
    }
  end
end
