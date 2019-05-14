# frozen_string_literal: true

class LogsController < ApplicationController
  layout 'no_white_container'

  def index
    @logs = integrated_logs.paginate(page: params[:page], per_page: 25)
  end

  private

  def integrated_logs
    logs = [
      current_user.pt_sessions.to_a,
      current_user.pain_logs.to_a,
      current_user.exercise_logs.at_home.to_a
    ]

    logs.flatten.sort_by { |a| a[:datetime_occurred] }.reverse!
  end
end
