# frozen_string_literal: true

class ExerciseLog < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  belongs_to :body_part

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

  def self.minutes_spent_by_day
    output = {}
    all.each do |log|
      if output[log.datetime_occurred.to_date] == nil
        output[log.datetime_occurred.to_date] = log.minutes_spent.round(2)
      else
        output[log.datetime_occurred.to_date] += log.minutes_spent.round(2)
      end
    end
    output
  end

  def seconds_spent
    sets * reps * rep_length
  end

  def minutes_spent
    (seconds_spent.to_f / 60)
  end

end
