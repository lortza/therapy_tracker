# frozen_string_literal: true

class SlitLogReportsController < ApplicationController
  def index
    start_date = search_params[:start_date].to_date.beginning_of_day
    end_date = search_params[:end_date].to_date.end_of_day
    logs = current_user.slit_logs.where(occurred_at: start_date..end_date)
                       .order(occurred_at: :asc)
                       .paginate(page: params[:page], per_page: SlitLogReport::RECORD_LIMIT)

    @logs = SlitLogDecorator.decorate_collection(logs)
  end

  def new
  end

  private

  def search_params
    params.permit(:start_date, :end_date)
  end
end
