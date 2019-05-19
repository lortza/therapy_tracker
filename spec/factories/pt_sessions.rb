# frozen_string_literal: true

FactoryBot.define do
  factory :pt_session do
    user
    body_part
    datetime_occurred { "2019-03-25 22:29:28" }
    exercise_notes { "sample exercise notes" }
    homework { "sample homework" }
    duration { [45, 60, 90].sample }
  end

  trait :with_homework_exercise do
    after :create do |pt_session|
      create :homework_exercise, pt_session: pt_session, exercise: create(:exercise)
    end
  end

end
