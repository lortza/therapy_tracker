# frozen_string_literal: true

# == Schema Information
#
# Table name: surveys
#
#  id                             :uuid             not null, primary key
#  available_to_public            :boolean          default(FALSE), not null
#  calculated_question_max_points :integer
#  calculated_question_min_points :integer
#  description                    :text
#  name                           :string           not null
#  published                      :boolean          default(FALSE), not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  user_id                        :bigint
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
    calculated_question_min_points { nil }
    calculated_question_max_points { nil }
    published { false }
    available_to_public { false }
  end
end
