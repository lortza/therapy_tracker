# frozen_string_literal: true

module PtSessionsHelper
  def display_exercise_stats(log)
    output = "#{log.sets} sets of #{log.reps} reps" unless log.blank_stats?
    output += " with #{log.resistance}" unless log.resistance.blank?
    output
  end
end
