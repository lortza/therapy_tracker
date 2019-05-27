class Report
  attr_reader :exercise_logs, :pain_logs, :pt_sessions, :pains, :exercises, :body_parts
  def initialize(args)
    @filter_params = args
    @exercise_logs ||= query_logs('exercise_logs')
    @pain_logs ||= query_logs('pain_logs')
    @pt_sessions ||= query_logs('pt_sessions')
    @pains ||= @filter_params[:user].pains
    @exercises ||= @filter_params[:user].exercises
    @body_parts ||= @filter_params[:user].body_parts
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
