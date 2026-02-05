# == Schema Information
#
# Table name: slit_logs
#
#  id                 :bigint           not null, primary key
#  dose_skipped       :boolean
#  doses_remaining    :integer
#  occurred_at        :datetime
#  started_new_bottle :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_slit_logs_on_occurred_at  (occurred_at)
#  index_slit_logs_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

# frozen_string_literal: true

FactoryBot.define do
  factory :slit_log do
    user { nil }
    # occurred_at { "2024-03-07 18:39:59" }
    occurred_at { nil }
    started_new_bottle { false }
    doses_remaining { nil }
    dose_skipped { false }
  end
end
