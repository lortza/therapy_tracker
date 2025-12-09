# frozen_string_literal: true

class Report
  attr_reader :user, :body_part, :timeframe
  TIMEFRAMES = [["Past Week", 7],
    ["Past Two Weeks", 14],
    ["Past Month", 30],
    ["Past Year", 360]].freeze

  def initialize(user:, timeframe:, body_part_id:)
    @user = user
    @timeframe = timeframe.presence&.to_i
    @body_part = BodyPart.find_by(id: body_part_id)
  end

  def exercise_logs
    @exercise_logs ||= query_logs(ExerciseLog)
  end

  def pain_logs
    @pain_logs ||= query_logs(PainLog)
  end

  def pt_session_logs
    @pt_session_logs ||= query_logs(PtSessionLog)
  end


  def exercise_log_count_by_body_part
    exercise_logs.group("body_parts.name")
      .joins(:body_part)
      .order("body_parts.name")
      .count
      .to_a
  end

  def exercises
    @exercises ||= user.exercises
  end

  def body_parts
    @body_parts ||= user.body_parts
  end

  def pain_stats_by_body_part
    pain_logs.includes(:body_part).group_by(&:body_part)
  end

  private

  def query_logs(log_type)
    logs = log_type.where(user_id: user.id)

    logs = logs.for_body_part(body_part.id) if body_part.present?
    logs = logs.for_past_n_days(timeframe) if timeframe.present?
    logs
  end
end
