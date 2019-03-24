class LogEntry < ApplicationRecord

  validates :target_body_part,
            :datetime_exercised,
            :exercise_name,
            :current_pain_frequency,
            presence: true

  validates :sets,
            :reps,
            :current_pain_level,
            presence: true,
            numericality: true

  EXERCISES = [
    'clam shells'
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
