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
