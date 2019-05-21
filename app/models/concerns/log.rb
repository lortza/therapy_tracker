# frozen_string_literal: true

module Log
  # class methods for querying logs
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
