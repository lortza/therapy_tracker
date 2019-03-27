class LogsController < ApplicationController
  def index
    physical_therapy_sessions = current_user.physical_therapy_sessions
    pain_logs = current_user.pain_logs
    exercise_logs = current_user.exercise_logs

    @logs ||= [physical_therapy_sessions.to_a, pain_logs.to_a, exercise_logs.to_a].flatten.sort_by { |a| a[:datetime_occurred] }.reverse!
  end
end
