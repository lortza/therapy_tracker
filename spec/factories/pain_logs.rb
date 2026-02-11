# frozen_string_literal: true

# == Schema Information
#
# Table name: pain_logs
#
#  id               :bigint           not null, primary key
#  occurred_at      :datetime
#  pain_description :text             default("")
#  pain_level       :integer
#  trigger          :text             default("")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  body_part_id     :bigint
#  pain_id          :bigint
#  user_id          :bigint
#
# Indexes
#
#  index_pain_logs_on_body_part_id  (body_part_id)
#  index_pain_logs_on_occurred_at   (occurred_at)
#  index_pain_logs_on_pain_id       (pain_id)
#  index_pain_logs_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (body_part_id => body_parts.id)
#  fk_rails_...  (pain_id => pains.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :pain_log do
    user
    body_part
    pain
    occurred_at { "2019-03-25 20:15:37" }
    pain_level { rand(1..5) }
    pain_description { "sample pain description" }
    trigger { "sample pain trigger" }
  end
end
