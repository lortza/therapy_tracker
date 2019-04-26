# frozen_string_literal: true

class PtSession < ApplicationRecord
  belongs_to :user
  belongs_to :body_part

  has_many :pt_session_exercises, inverse_of: :pt_session, dependent: :destroy
  accepts_nested_attributes_for :pt_session_exercises,
                                reject_if: :all_blank, # at least 1 exercise should be present
                                allow_destroy: true # allows user to delete exercise via checkbox

  has_many :pt_homework_exercises, dependent: :destroy
  has_many :homework_exercises, through: :pt_homework_exercises, source: :exercise


  validates :datetime_occurred,
            :body_part_id,
            :exercise_notes,
            :homework,
            presence: true

  validates :duration,
            presence: true,
            numericality: true

  delegate :name, to: :body_part, prefix: true

  def exercise_notes_to_lines
    self.exercise_notes = exercise_notes.gsub(/\r/, "\n")
  end
end
