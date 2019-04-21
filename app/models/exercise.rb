# frozen_string_literal: true

class Exercise < ApplicationRecord
  belongs_to :user
  has_many :exercise_logs
  has_many :logs, foreign_key: 'user_id', class_name: 'ExerciseLog'
  # has_many :homework_exercises

  has_many :pt_session_exercises, dependent: :destroy
  has_many :pt_sessions, through: :pt_session_exercises

  validates :name,
            :description,
            :default_sets,
            :default_reps,
            :default_rep_length,
            presence: true

  def self.by_name
    order(:name)
  end

  def self.has_logs
    joins(:exercise_logs).group('exercises.id').order(:id)
  end

  def self.log_count_by_name
    has_logs.map do |exercise|
      [exercise.name, exercise.exercise_logs.count]
    end
  end
end
