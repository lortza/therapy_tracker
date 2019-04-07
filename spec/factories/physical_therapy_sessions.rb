# frozen_string_literal: true

FactoryBot.define do
  factory :physical_therapy_session do
    user { nil }
    body_part
    datetime_occurred { "2019-03-25 22:29:28" }
    exercise_notes { "MyText" }
    homework { "MyText" }
    duration { 1 }
  end
end
