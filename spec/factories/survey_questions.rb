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
FactoryBot.define do
  factory :survey_question, class: Survey::Question do
    association :category, factory: :survey_category
    sequence(:text) { |n| "survey_question#{n}" }
    sequence(:position) { |n| n - 1 }
  end
end
