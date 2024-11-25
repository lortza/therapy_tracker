# frozen_string_literal: true

module Log
  # class methods for querying logs
  def self.all(user)
    logs = [
      user.pt_session_logs.decorate.to_a,
      user.pain_logs.decorate.to_a,
      user.exercise_logs.at_home.decorate.to_a,
      user.slit_logs.decorate.to_a
    ]

    logs.flatten.sort_by { |a| a[:occurred_at] }.reverse!
  end

  def chronologically
    all.order(:occurred_at)
  end

  def for_past_n_days(qty_days)
    where("occurred_at >= ? AND occurred_at <= ?", qty_days.days.ago, today)
  end

  def for_body_part(id)
    where(body_part_id: id)
  end

  private

  def today
    Time.zone.now
  end
end
