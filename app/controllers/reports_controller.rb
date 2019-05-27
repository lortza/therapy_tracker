# frozen_string_literal: true

class ReportsController < ApplicationController
  # layout 'no_white_container'

  def index
    filter_params = {
      user: current_user,
      timeframe: params[:timeframe],
      body_part_id: params[:body_part_id]
    }
    
    @report = Report.new(filter_params)
  end
end
