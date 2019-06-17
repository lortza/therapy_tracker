# frozen_string_literal: true

class PtHomeworkExercise < ApplicationRecord
  belongs_to :pt_session_log
  belongs_to :exercise

  validates :pt_session_log, :exercise, presence: true
end
