# frozen_string_literal: true

class SlitLogReportsController < ApplicationController
  def index
    report_record_limit = 90
    @index_to_prompt_calling = 45
    logs = current_user.slit_logs
                       .where(occurred_at: report_record_limit.days.ago..Time.current)
                       .order(occurred_at: :asc)
                       .limit(report_record_limit)
                       .paginate(page: params[:page], per_page: 10)

    @logs = SlitLogDecorator.decorate_collection(logs)
  end
end
