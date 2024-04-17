# frozen_string_literal: true

module LogsHelper
  def format_datetime(datetime)
    # log.datetime.strftime("%a %m/%d/%y at %I:%M %p in %Z")
    datetime.strftime('%a %m/%d/%y at %I:%M%p')
  end

  def format_time_today_at(datetime)
    datetime.strftime('Today at %I:%M %p')
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

  def options_for_body_parts_dropdown
    # current_user.body_parts.order(:name).map(&:name)
    current_user.body_parts.map { |b| [b.name, b.id] }
  end

  def options_for_pain_logs_dropdown
    # current_user.pains.order(:name).map(&:name)
    current_user.pains.order(:name).map { |p| [p.name, p.id] }
  end
end
