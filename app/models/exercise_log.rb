# frozen_string_literal: true

class ExerciseLog < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  belongs_to :body_part
  belongs_to :pt_session, optional: true

  validates :datetime_occurred,
            :exercise_id,
            :body_part_id,
            presence: true

  validates :sets,
            :reps,
            :rep_length,
            presence: true,
            numericality: true

  validates_presence_of :burn_set,
                        :burn_rep,
                        on: :update

  validates_numericality_of :burn_set,
                            :burn_rep,
                            on: :update

  delegate :name, to: :body_part, prefix: true
  delegate :name, to: :exercise, prefix: true

  def self.past_week
    where('datetime_occurred >= ? AND datetime_occurred <= ?', (Date.today.to_datetime - 7.days), Date.today.to_datetime)
  end

  def self.past_two_weeks
    where('datetime_occurred >= ? AND datetime_occurred <= ?', (Date.today.to_datetime - 14.days), Date.today.to_datetime)
  end

  def self.group_by_exercise_and_count
    ex_ids_and_counts = group(:exercise_id).count
    ex_ids_and_counts.map do |k, v|
      [ Exercise.find(k).name, v ]
    end
  end

  def self.minutes_spent_by_day
    output = {}
    all.each do |log|
      if output[log.datetime_occurred.to_date] == nil
        output[log.datetime_occurred.to_date] = log.minutes_spent.round(2)
      else
        output[log.datetime_occurred.to_date] += log.minutes_spent.round(2)
      end
    end
    output.sort.to_h
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

end
