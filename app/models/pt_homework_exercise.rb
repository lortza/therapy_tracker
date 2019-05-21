# frozen_string_literal: true

class PtHomeworkExercise < ApplicationRecord
  belongs_to :pt_session
  belongs_to :exercise

  validates :pt_session, :exercise, presence: true
end
