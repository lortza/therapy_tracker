# frozen_string_literal: true

FactoryBot.define do
  factory :exercise_log do
    user
    exercise
    body_part
    pt_session_log_id { nil }
    occurred_at { "2019-03-23 14:08:03" }
    sets { 2 }
    reps { 10 }
    rep_length { 5 }
    burn_set { 2 }
    burn_rep { 5 }
    resistance { ["", "yellow band", "green band"].sample }
    progress_note { "progress note body" }
  end
end
