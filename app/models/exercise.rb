class Exercise < ApplicationRecord
  belongs_to :user
  has_many :exercise_logs

  validates :name,
            :description,
            :default_sets,
            :default_reps,
            :default_rep_length,
            presence: true

  def self.mapped
    all.map do |exercise|
      {id: exercise.id, sets: exercise.default_sets, reps: exercise.default_reps, rep_length: exercise.default_rep_length }
    end
  end

end
