# frozen_string_literal: true

# == Schema Information
#
# Table name: surveys
#
#  id                  :uuid             not null, primary key
#  available_to_public :boolean          default(FALSE), not null
#  description         :text
#  name                :string           not null
#  published           :boolean          default(FALSE), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint
#
# Indexes
#
#  index_surveys_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Survey < ApplicationRecord
  # A Survey is a way for a user to track their symptoms on a specific topic over time.
  # For example, an admin might create a "Depression Survey" with questions about mood,
  # sleep, appetite, etc. The user can then fill out the survey on a regular basis to track
  # their symptoms and share the results with their therapist.

  belongs_to :user, optional: true

  has_many :categories, class_name: "Survey::Category", dependent: :destroy
  has_many :questions, through: :categories, class_name: "Survey::Question"
  has_many :answer_options, class_name: "Survey::AnswerOption", dependent: :destroy
  has_many :score_ranges, class_name: "Survey::ScoreRange", dependent: :destroy

  has_many :enrollments, class_name: "Survey::Enrollment", foreign_key: "survey_id", dependent: :destroy
  has_many :users, through: :enrollments
  has_many :responses, class_name: "Survey::Response", foreign_key: "survey_id", dependent: :destroy

  normalizes :name, with: ->(name) { name.strip.squish }
  validates :name,
    presence: true,
    uniqueness: {case_sensitive: false}
end
