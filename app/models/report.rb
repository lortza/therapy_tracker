# frozen_string_literal: true

class Report
  attr_reader :exercise_logs, :pain_logs, :pt_sessions, :pains, :exercises, :body_parts

  def initialize(args)
    @exercise_logs = args[:exercise_logs]
    @pain_logs = args[:pain_logs]
    @pt_sessions = args[:pt_sessions]
    @pains = args[:pains]
    @exercises = args[:exercises]
    @body_parts = args[:body_parts]
  end

  class << self
    def build_report(filter_params) # rubocop:disable Metrics/MethodLength
      @filter_params = filter_params
      exercise_logs = query_logs('exercise_logs')
      pain_logs = query_logs('pain_logs')
      pt_sessions = query_logs('pt_sessions')
      pains = filter_params[:user].pains
      exercises = filter_params[:user].exercises
      body_parts = filter_params[:user].body_parts

      Report.new(
        exercise_logs: exercise_logs,
        pain_logs: pain_logs,
        pt_sessions: pt_sessions,
        pains: pains,
        exercises: exercises,
        body_parts: body_parts
      )
    end

    private

    def query_logs(log_type)
      logs = log_type.classify
                     .constantize
                     .where(user_id: @filter_params[:user].id)

      logs = logs.for_body_part(@filter_params[:body_part_id]) if @filter_params[:body_part_id].present?
      logs = logs.for_past_n_days(@filter_params[:timeframe].to_i) if @filter_params[:timeframe].present?
      logs
    end
  end
end
