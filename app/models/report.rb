# frozen_string_literal: true

class Report
  attr_reader :filter_params
  TIMEFRAMES = [["Past Week", 7],
    ["Past Two Weeks", 14],
    ["Past Month", 30],
    ["Past Year", 360]].freeze

  def initialize(filter_params)
    @filter_params = filter_params
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

  def pains
    @pains ||= filter_params[:user].pains
  end

  def exercises
    @exercises ||= filter_params[:user].exercises
  end

  def body_parts
    @body_parts ||= filter_params[:user].body_parts
  end

  def pain_stats_by_body_part
    pain_logs.includes(:body_part).group_by(&:body_part)
  end

  private

  def query_logs(log_type)
    logs = log_type.where(user_id: @filter_params[:user].id)

    logs = logs.for_body_part(@filter_params[:body_part_id]) if @filter_params[:body_part_id].present?
    logs = logs.for_past_n_days(@filter_params[:timeframe].to_i) if @filter_params[:timeframe].present?
    logs
  end
end
