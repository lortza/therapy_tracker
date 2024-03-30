# frozen_string_literal: true

class ExerciseLog < ApplicationRecord
  extend Log

  belongs_to :user
  belongs_to :exercise
  belongs_to :body_part
  belongs_to :pt_session_log, optional: true

  validates :occurred_at,
            :exercise_id,
            :body_part_id,
            presence: true

  validates :sets,
            :reps,
            :rep_length,
            presence: true,
            numericality: true

  validates :burn_set,
            :burn_rep,
            presence: { on: :update }

  validates :burn_set,
            :burn_rep,
            numericality: { on: :update }

  delegate :name, to: :body_part, prefix: true
  delegate :name, to: :exercise, prefix: true

  scope :at_home, -> { where(pt_session_log_id: nil) }
  scope :at_pt, -> { where.not(pt_session_log_id: nil) }

  class << self
    def group_by_exercise_and_count
      ex_ids_and_counts = group(:exercise_id).count
      ex_ids_and_counts.map do |k, v|
        [Exercise.find(k).name, v]
      end
    end

    def minutes_spent_by_day
      output = {}
      all.find_each do |log|
        occurred = log.occurred_at.to_date

        if output[occurred].nil?
          output[occurred] = log.minutes_spent.round(2)
        else
          output[occurred] += log.minutes_spent.round(2)
        end
      end
      output.sort.to_h
    end
  end

  def seconds_spent
    side_multiplier = per_side ? 2 : 1
    sets * reps * rep_length * side_multiplier
  end

  def minutes_spent
    (seconds_spent.to_f / 60)
  end

  def blank_stats?
    sets.blank? || reps.blank?
  end

  def display_name
    'Exercise'
  end

  def self.icon_name
    'exercise'
  end

  def icon_name
    ExerciseLog.icon_name
  end

  def css_name
    'exercise'
  end
end
