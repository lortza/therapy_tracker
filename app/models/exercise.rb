# frozen_string_literal: true

class Exercise < ApplicationRecord
  extend Nameable

  belongs_to :user
  has_many :exercise_logs, dependent: :destroy
  has_many :logs, class_name: "ExerciseLog", dependent: :destroy, inverse_of: :exercise

  has_many :pt_homework_exercises, dependent: :destroy # the join table
  has_many :pt_homework_sessions, through: :pt_homework_exercises, source: :pt_session_log

  validates :description,
    :default_sets,
    :default_reps,
    :default_rep_length,
    presence: true

  validates :name,
    presence: true,
    uniqueness: {
      case_sensitive: false,
      scope: :user_id
    }

  class << self
    def logs?
      joins(:exercise_logs).group("exercises.id").order(:id)
    end

    def log_count_by_name
      qualifying_logs = logs?.select do |exercise|
        exercise.logs.count > 2
      end

      qualifying_logs.map { |e| [e.name, e.logs.count] }
    end
  end
end
