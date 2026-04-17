# frozen_string_literal: true

# == Schema Information
#
# Table name: survey_responses
#
#  id          :uuid             not null, primary key
#  notes       :text
#  occurred_at :datetime         not null
#  total_score :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  survey_id   :uuid             not null
#  user_id     :bigint           not null
#
# Indexes
#
#  idx_on_user_id_survey_id_occurred_at_2e691e6025  (user_id,survey_id,occurred_at)
#  index_survey_responses_on_survey_id              (survey_id)
#  index_survey_responses_on_user_id                (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :survey_response, class: Survey::Response do
    survey
    user
    sequence(:occurred_at) { |n| Time.current - n.days }
    total_score { 0 }
    notes { nil }
  end
end
