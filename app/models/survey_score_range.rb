# frozen_string_literal: true

# == Schema Information
#
# Table name: survey_score_ranges
#
#  id              :uuid             not null, primary key
#  name            :string
#  range_max_value :integer          not null
#  range_min_value :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  survey_id       :uuid             not null
#
# Indexes
#
#  index_survey_score_ranges_on_survey_id  (survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)
#
class SurveyScoreRange < ApplicationRecord
  # Only Admins edit this table
  # A SurveyScoreRange defines a range of scores for a survey and the corresponding interpretation.
  # For example, if a survey has a total score that can range from 0 to 30, you might have score
  # ranges like 0-10 = "Mild", 11-20 = "Moderate", and 21-30 = "Severe". This allows you to interpret
  # the total score of a survey response in a meaningful way.

  belongs_to :survey

  validates :range_min_value,
    presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 0},
    uniqueness: {scope: :survey_id, case_sensitive: false}

  validates :range_max_value,
    presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: :range_min_value},
    uniqueness: {scope: :survey_id, case_sensitive: false}

  normalizes :name, with: ->(name) { name.strip.squish }
  validates :name,
    presence: true,
    uniqueness: {scope: :survey_id, case_sensitive: false}
end
