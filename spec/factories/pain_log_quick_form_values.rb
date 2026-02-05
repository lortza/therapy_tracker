# == Schema Information
#
# Table name: pain_log_quick_form_values
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  pain_description :text
#  pain_level       :integer
#  trigger          :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  body_part_id     :bigint
#  pain_id          :bigint
#  user_id          :bigint
#
# Indexes
#
#  index_pain_log_quick_form_values_on_body_part_id  (body_part_id)
#  index_pain_log_quick_form_values_on_pain_id       (pain_id)
#  index_pain_log_quick_form_values_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (body_part_id => body_parts.id)
#  fk_rails_...  (pain_id => pains.id)
#  fk_rails_...  (user_id => users.id)
#

# frozen_string_literal: true

FactoryBot.define do
  factory :pain_log_quick_form_value do
    sequence(:name) { |n| "Name #{n}" }
    user
    body_part
    pain
    pain_level { rand(1..5) }
    pain_description { "sample pain description" }
    trigger { "sample pain trigger" }
  end
end
