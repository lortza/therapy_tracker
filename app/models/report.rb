class Report
  attr_reader :exercise_logs, :pain_logs, :pt_sessions, :pains
  def initialize(args)
    @filter_params = args
    @exercise_logs = query_logs('exercise_logs')
    @pain_logs = query_logs('pain_logs')
    @pt_sessions = query_logs('pt_sessions')
    @pains = query_obj('pain')
  end

  # scope :for_body_part, -> (body_part_id) { where body_part_id: body_part_id }


  private
  def query_obj(obj_type)
    obj_type.classify.constantize.where(user_id: @filter_params[:user].id)
  end

  def query_logs(log_type)
    log_type.classify
            .constantize
            .where(user_id: @filter_params[:user].id)
            .where(body_part_id: @filter_params[:body_part_id])
  end
end
