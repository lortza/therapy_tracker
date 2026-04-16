# frozen_string_literal: true

# == Schema Information
#
# Table name: surveys
#
#  id          :uuid             not null, primary key
#  description :text
#  name        :string           not null
#  published   :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Survey < ApplicationRecord
  # Only Admins edit this table
  # A Survey is a way for a user to track their symptoms on a specific topic over time.
  # For example, an admin might create a "Depression Survey" with questions about mood,
  # sleep, appetite, etc. The user can then fill out the survey on a regular basis to track
  # their symptoms and share the results with their therapist.

  has_many :survey_categories, dependent: :destroy
  has_many :questions, through: :survey_categories, source: :survey_questions
  has_many :survey_answer_options, dependent: :destroy
  has_many :survey_score_ranges, dependent: :destroy

  has_many :survey_enrollments, dependent: :destroy
  has_many :users, through: :survey_enrollments
  has_many :survey_responses, dependent: :destroy

  normalizes :name, with: ->(name) { name.strip.squish }
  validates :name,
    presence: true,
    uniqueness: {case_sensitive: false}
end
