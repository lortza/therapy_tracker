# frozen_string_literal: true

class Exercise < ApplicationRecord
  belongs_to :user
  has_many :exercise_logs, dependent: :destroy
  has_many :logs, foreign_key: 'exercise_id', class_name: 'ExerciseLog', dependent: :destroy

  has_many :pt_homework_exercises, dependent: :destroy # the join table
  has_many :pt_homework_sessions, through: :pt_homework_exercises, source: :pt_session

  validates :description,
            :default_sets,
            :default_reps,
            :default_rep_length,
            presence: true

  validates :name,
            presence: true,
            uniqueness: true

  class << self
    def by_name
      order('lower(name) ASC')
    end

    def has_logs
      joins(:exercise_logs).group('exercises.id').order(:id)
    end

    def log_count_by_name
      has_logs.select do |exercise|
        exercise.logs.count > 2
      end.map { |e| [e.name, e.logs.count] }
    end

    def search(terms)
      if terms.blank?
        all
      else
        where('name ILIKE ?', "%#{terms}%")
      end
    end
  end
end
