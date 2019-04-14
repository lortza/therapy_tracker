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

  def self.total_minutes_spent
    all.map(&:minutes_spent).reduce(:+)
  end

  def minutes_spent
    sets * reps * rep_length / 60
  end
end
