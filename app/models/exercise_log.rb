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

  validates_numericality_of :burn_rep, on: :update

  delegate :name, to: :exercise, prefix: true
  delegate :name, to: :body_part, prefix: true
end
