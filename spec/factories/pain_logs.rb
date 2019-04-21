# frozen_string_literal: true

FactoryBot.define do
  factory :pain_log do
    user
    body_part
    pain
    datetime_occurred { '2019-03-25 20:15:37' }
    pain_level { (1..5).to_a.sample }
    pain_description { 'sample pain description' }
    trigger { 'sample pain trigger' }
  end
end
