FactoryBot.define do
  factory :exercise_log do
    user
    exercise
    body_part
    datetime_occurred { '2019-03-23 14:08:03' }
    sets { 2 }
    reps { 10 }
    rep_length { 5 }
    progress_note { 'progress note body' }
  end
end
