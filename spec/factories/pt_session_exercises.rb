FactoryBot.define do
  factory :pt_session_exercise do
    pt_session { nil }
    exercise_id { nil }
    sets { rand(1..4) }
    reps { rand(5..15) }
    resistance { ['', 'yellow band', 'green band'].sample }
  end
end
