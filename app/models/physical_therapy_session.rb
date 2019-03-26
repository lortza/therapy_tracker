class PhysicalTherapySession < ApplicationRecord
  belongs_to :user

  validates :datetime_occurred,
            :target_body_part,
            :exercise_notes,
            :homework,
            presence: true

  validates :duration,
            presence: true,
            numericality: true

  def exercise_notes_to_lines
    self.exercise_notes = exercise_notes.gsub(/\r/, "\n")
  end
end
