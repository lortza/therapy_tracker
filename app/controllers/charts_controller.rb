# frozen_string_literal: true

class ChartsController < ApplicationController
  def index
    @report = Report.new(
      user: current_user,
      timeframe: params[:timeframe],
      body_part_id: params[:body_part_id]
    )
  end
end
