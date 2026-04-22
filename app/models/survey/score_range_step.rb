# frozen_string_literal: true

# == Schema Information
#
# Table name: survey_score_range_steps
#
#  id                          :uuid             not null, primary key
#  calculated_range_max_points :integer
#  calculated_range_min_points :integer
#  description                 :text
#  name                        :string           not null
#  position                    :integer          not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  survey_id                   :uuid             not null
#
# Indexes
#
#  index_survey_score_range_steps_on_survey_id  (survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)
#
class Survey::ScoreRangeStep < ApplicationRecord
  # A Survey::ScoreRangeStep defines a range of scores for a survey and the corresponding interpretation.
  # For example, if a survey has a total score that can range from 0 to 30, you might have score
  # ranges like 0-10 = "Mild", 11-20 = "Moderate", and 21-30 = "Severe". This allows you to interpret
  # the total score of a survey response in a meaningful way. This must be calculated LAST, after all
  # other survey components are in place, since it relies on the counts of other components.

  belongs_to :survey

  validates :calculated_range_min_points,
    numericality: {only_integer: true, greater_than_or_equal_to: 0},
    uniqueness: {scope: :survey_id},
    allow_nil: true

  validates :calculated_range_max_points,
    numericality: {only_integer: true, greater_than_or_equal_to: :calculated_range_min_points},
    uniqueness: {scope: :survey_id},
    allow_nil: true

  normalizes :name, with: ->(name) { name.strip.squish }
  validates :name,
    presence: true,
    uniqueness: {scope: :survey_id, case_sensitive: false}

  validates :position,
    presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 0},
    uniqueness: {scope: :survey_id}

  scope :ordered, -> { order(position: :asc) }
end
