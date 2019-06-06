# frozen_string_literal: true

class Report
  attr_reader :filter_params

  def initialize(filter_params)
    @filter_params = filter_params
  end

  def exercise_logs
    @exercise_logs ||= query_logs(ExerciseLog)
  end

  def pain_logs
    @pain_logs ||= query_logs(PainLog)
  end

  def pt_sessions
    @pt_sessions ||= query_logs(PtSession)
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

  private

  def query_logs(log_type)
    logs = log_type.where(user_id: @filter_params[:user].id)

    logs = logs.for_body_part(@filter_params[:body_part_id]) if @filter_params[:body_part_id].present?
    logs = logs.for_past_n_days(@filter_params[:timeframe].to_i) if @filter_params[:timeframe].present?
    logs
  end
end
