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
FactoryBot.define do
  factory :survey_score_range_step, class: Survey::ScoreRangeStep do
    survey
    sequence(:name) { |n| "survey_score_range_step#{n}" }
    sequence(:position) { |n| n + 1 }
    sequence(:description) { |n| "Example description #{n}" }
    calculated_range_min_points { nil }
    calculated_range_max_points { nil }
  end
end
