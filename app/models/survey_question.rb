# frozen_string_literal: true

# == Schema Information
#
# Table name: survey_questions
#
#  id                 :uuid             not null, primary key
#  position           :integer          default(0), not null
#  text               :text             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  survey_category_id :uuid             not null
#
# Indexes
#
#  index_survey_questions_on_survey_category_id  (survey_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_category_id => survey_categories.id)
#
class SurveyQuestion < ApplicationRecord
  # Only Admins edit this table
  # A SurveyQuestion represents a single question within a survey. For example, in
  # a "Depression Survey", a question might be "how often have you felt hopeless?" and
  # That question would belong to a SurveyCategory like "Feelings".

  belongs_to :survey_category
  delegate :survey, to: :survey_category
  has_many :survey_answers, dependent: :destroy

  normalizes :text, with: ->(text) { text.strip.squish }
  validates :text,
    presence: true,
    uniqueness: {scope: :survey_category_id, case_sensitive: false}
  validates :position, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
end
