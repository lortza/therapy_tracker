class Exercise < ApplicationRecord
  belongs_to :user
  has_many :exercise_logs

  validates :name,
            :description,
            :default_sets,
            :default_reps,
            :default_rep_length,
            presence: true
end
