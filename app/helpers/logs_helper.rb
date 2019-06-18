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
    return false if current_user.pt_session_logs.last.nil?

    {
      notes: current_user.pt_session_logs.last&.homework,
      exercises: current_user.pt_session_logs.last&.homework_exercises
    }
  end

  def user_has_all_required_data(user)
    user.body_parts.any? && user.pains.any? && user.exercises.any?
  end

  def user_needs_data_for_section(user, attr)
    user.send(attr).empty?
  end
end
