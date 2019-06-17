# frozen_string_literal: true

FactoryBot.define do
  factory :pt_homework_exercise do
    pt_session_log { nil }
    exercise { nil }
  end
end
