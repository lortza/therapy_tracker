# frozen_string_literal: true

# == Schema Information
#
# Table name: survey_categories
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  position   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  survey_id  :uuid             not null
#
# Indexes
#
#  index_survey_categories_on_survey_id  (survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)
#
FactoryBot.define do
  factory :survey_category do
    survey
    sequence(:name) { |n| "survey_category#{n}" }
    sequence(:position) { |n| n - 1 }
  end
end
