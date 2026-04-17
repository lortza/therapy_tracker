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
FactoryBot.define do
  factory :survey_score_range, class: Survey::ScoreRange do
    survey
    sequence(:name) { |n| "survey_score_range#{n}" }
    sequence(:range_min_value) { |n| n - 1 }
    sequence(:range_max_value) { |n| n + 1 }
  end
end
