class PhysicalTherapySession < ApplicationRecord
  belongs_to :user
  belongs_to :body_part

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
