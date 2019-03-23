FactoryBot.define do
  factory :log_entry do
    sets { 1 }
    reps { 1 }
    exercise_name { "MyString" }
    datetime_exercised { "2019-03-23 14:08:03" }
    current_pain_level { 1 }
    current_pain_frequency { "MyString" }
    progress_note { "MyText" }
  end
end
