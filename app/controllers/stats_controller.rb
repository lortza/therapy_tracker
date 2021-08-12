# frozen_string_literal: true

class StatsController < ApplicationController
  def index
    filter_params = {
      user: current_user,
      timeframe: params[:timeframe],
      body_part_id: params[:body_part_id]
    }

    @report = Report.new(filter_params)
    @body_parts = @report.stats_by_body_part
  end
end
