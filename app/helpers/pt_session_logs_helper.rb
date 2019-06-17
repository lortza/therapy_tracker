# frozen_string_literal: true

module PtSessionLogsHelper
  def display_exercise_stats(log)
    output = "#{log.sets} sets of #{log.reps} reps" unless log.blank_stats?
    output += " with #{log.resistance}" if log.resistance.present?
    output
  end
end
