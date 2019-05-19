# frozen_string_literal: true

class BodyPart < ApplicationRecord
  belongs_to :user
  has_many :exercise_logs
  has_many :pain_logs
  has_many :pt_sessions

  validates :name, presence: true
end
