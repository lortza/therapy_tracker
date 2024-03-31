# frozen_string_literal: true

class PtSessionLog < ApplicationRecord
  extend Log

  belongs_to :user
  belongs_to :body_part
  has_many :exercise_logs, dependent: :destroy

  has_many :pt_homework_exercises, dependent: :destroy
  has_many :homework_exercises, through: :pt_homework_exercises, source: :exercise

  validates :occurred_at,
            :body_part_id,
            :exercise_notes,
            :homework,
            presence: true

  validates :duration,
            presence: true,
            numericality: true

  delegate :name, to: :body_part, prefix: true

  def self.exercise_counts
    output = {}
    all.order(:occurred_at).each do |session|
      output[session.occurred_at.to_date] = session.exercise_logs.count
    end
    output
  end
end
