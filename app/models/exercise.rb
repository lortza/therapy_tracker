# frozen_string_literal: true

class Exercise < ApplicationRecord
  belongs_to :user
  has_many :exercise_logs
  has_many :logs, foreign_key: 'exercise_id', class_name: 'ExerciseLog'

  has_many :pt_homework_exercises, dependent: :destroy  # the join table
  has_many :pt_homework_sessions, through: :pt_homework_exercises, source: :pt_session

  has_many :pt_session_exercises, dependent: :destroy  # the join table
  has_many :pt_exercise_sessions, through: :pt_session_exercises, source: :pt_session

  validates :description,
            :default_sets,
            :default_reps,
            :default_rep_length,
            presence: true

  validates :name,
            presence: true,
            uniqueness: true

  def self.by_name
    order(:name)
  end

  def self.has_logs
    joins(:exercise_logs).group('exercises.id').order(:id)
  end

  def self.log_count_by_name
    exercises = has_logs.select do |exercise|
      exercise.logs.count > 1
    end.map { |e| [e.name, e.logs.count] }
  end
end
