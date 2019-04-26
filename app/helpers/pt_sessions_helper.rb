# frozen_string_literal: true

module PtSessionsHelper
  def display_exercise_stats(exercise)
    output = "#{exercise.exercise_name}"
    output += ": #{exercise.sets} sets of #{exercise.reps} reps" unless exercise.blank_stats?
    output += " with #{exercise.resistance}" unless exercise.resistance.blank?
    output
  end
end
