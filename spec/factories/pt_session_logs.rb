# frozen_string_literal: true

FactoryBot.define do
  factory :pt_session_log do
    user
    body_part
    occurred_at { '2019-03-25 22:29:28' }
    questions { 'sample question?' }
    exercise_notes { 'sample exercise notes' }
    homework { 'sample homework' }
    duration { [45, 60, 90].sample }
  end

  trait :with_homework_exercise do
    after :create do |pt_session_log|
      create :homework_exercise, pt_session_log: pt_session_log, exercise: create(:exercise)
    end
  end
end
