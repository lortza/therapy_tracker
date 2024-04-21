# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:first_name) { '' }
    sequence(:last_name) { '' }
    # TODO: make email default to ''
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    enable_slit_tracking { false }
    enable_pt_session_tracking { false }
  end
end
