class PtSessionExercise < ApplicationRecord
  belongs_to :pt_session
  belongs_to :exercise

  validates :pt_session, :exercise, presence: true
end
