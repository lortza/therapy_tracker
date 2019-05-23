# frozen_string_literal: true

class BodyPart < ApplicationRecord
  extend SharedParentMethods

  belongs_to :user
  has_many :exercise_logs, dependent: :destroy
  has_many :pain_logs, dependent: :destroy
  has_many :pt_sessions, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
