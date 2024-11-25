# frozen_string_literal: true

FactoryBot.define do
  factory :pain_log_quick_form_value do
    sequence(:name) { |n| "Name #{n}" }
    user
    body_part
    pain
    pain_level { rand(1..5) }
    pain_description { "sample pain description" }
    trigger { "sample pain trigger" }
  end
end
