FactoryBot.define do
  factory :log_entry do
    user
    sequence(:target_body_part) { |n| "Body part#{n}" }
    datetime_exercised { "2019-03-23 14:08:03" }
    sets { 2 }
    reps { 10 }
    sequence(:exercise_name) { |n| "Exercise#{n}" }
    sequence(:current_pain_frequency) { |n| "Frequency#{n}" }
    current_pain_level { 5 }
    progress_note { "progress note body" }
  end
end
