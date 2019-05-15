# frozen_string_literal: true

class PtSession < ApplicationRecord
  belongs_to :user
  belongs_to :body_part
  has_many :exercise_logs

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

  def self.past_week
    where('datetime_occurred >= ? AND datetime_occurred <= ?', (Date.today.to_datetime - 7.days), Date.today.to_datetime)
  end

  def self.past_two_weeks
    where('datetime_occurred >= ? AND datetime_occurred <= ?', (Date.today.to_datetime - 14.days), Date.today.to_datetime)
  end

  def exercise_notes_to_lines
    self.exercise_notes = exercise_notes.gsub(/\r/, "\n")
  end

  def self.exercise_counts
    output = {}
    all.order(:datetime_occurred).each do |session|
      output[session.datetime_occurred.to_date] = session.exercise_logs.count
    end
    output
  end
end
