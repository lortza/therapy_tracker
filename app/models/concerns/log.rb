# frozen_string_literal: true

module Log
  # class methods for querying logs
  def self.all(user)
    logs = [
      user.pt_sessions.to_a,
      user.pain_logs.to_a,
      user.exercise_logs.at_home.to_a,
    ]

    logs.flatten.sort_by { |a| a[:datetime_occurred] }.reverse!
  end

  def chronologically
    all.order(:datetime_occurred)
  end

  def past_week
    where('datetime_occurred >= ? AND datetime_occurred <= ?', (today - 7.days), today)
  end

  def past_two_weeks
    where('datetime_occurred >= ? AND datetime_occurred <= ?', (today - 14.days), today)
  end

  private

  def today
    Time.zone.today.to_datetime
  end
end
