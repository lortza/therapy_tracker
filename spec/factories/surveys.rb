# frozen_string_literal: true

# == Schema Information
#
# Table name: surveys
#
#  id                               :uuid             not null, primary key
#  auto_calculate_score_range_steps :boolean          default(TRUE), not null
#  available_to_public              :boolean          default(FALSE), not null
#  calculated_question_max_points   :integer
#  calculated_question_min_points   :integer
#  description                      :text
#  instructions                     :text
#  name                             :string           not null
#  status                           :integer          default("draft"), not null
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  user_id                          :bigint
#
# Indexes
#
#  index_surveys_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :survey do
    sequence(:name) { |n| "survey#{n}" }
    sequence(:description) { |n| "survey#{n} description" }
    sequence(:instructions) { |n| "survey#{n} instructions" }
    calculated_question_min_points { nil }
    calculated_question_max_points { nil }
    status { :draft }
    available_to_public { false }
    auto_calculate_score_range_steps { true }
  end
end
