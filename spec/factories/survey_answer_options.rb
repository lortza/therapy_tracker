# frozen_string_literal: true

# == Schema Information
#
# Table name: survey_answer_options
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  value      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  survey_id  :uuid             not null
#
# Indexes
#
#  index_survey_answer_options_on_survey_id  (survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)
#
FactoryBot.define do
  factory :survey_answer_option, class: Survey::AnswerOption do
    survey
    sequence(:name) { |n| "survey_answer_option#{n}" }
    sequence(:value) { |n| n - 1 }
  end
end
