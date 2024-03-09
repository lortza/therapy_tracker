FactoryBot.define do
  factory :slit_log do
    user { nil }
    # datetime_occurred { "2024-03-07 18:39:59" }
    datetime_occurred { nil }
    started_new_bottle { false }
    doses_remaining { nil }
  end
end
