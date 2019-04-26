class PtSessionExercise < ApplicationRecord
  belongs_to :pt_session, inverse_of: :pt_session_exercises
  belongs_to :exercise

  validates :pt_session, :exercise, presence: true

  delegate :name, to: :exercise, prefix: true

  def blank_stats?
    sets.blank? || reps.blank?
  end
end
