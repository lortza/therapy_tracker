# frozen_string_literal: true

class StatsController < ApplicationController
  def index
    @report = Report.new(filter_params)
  end

  private

  def filter_params
    {
      user: current_user,
      timeframe: params[:timeframe],
      body_part_id: params[:body_part_id]
    }
  end
end
