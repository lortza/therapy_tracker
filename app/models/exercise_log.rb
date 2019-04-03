class ExerciseLog < ApplicationRecord
  belongs_to :user
  belongs_to :exercise

  validates :target_body_part,
            :datetime_occurred,
            :exercise_id,
            presence: true

  validates :sets,
            :reps,
            :rep_length,
            :burn_rep,
            presence: true,
            numericality: true

  delegate :name, to: :exercise, prefix: true

  EXERCISES = [
    'clam shells',
    'bridges',
    'sample exercise'
  ]

  PAIN_FREQUENCY = [
    'constant',
    'most of day',
    'part of day',
    'only when provoked',
    'rarely'
  ]

  BODY_PARTS = [
    'hip - right',
    'hip - left',
    'knee - right',
    'knee - left',
  ]
end
