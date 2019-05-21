# frozen_string_literal: true

FactoryBot.define do
  factory :pain do
    user
    sequence(:name) { |n| "pain#{n}" }
  end

  trait :with_3_pain_logs do
    after :create do |pain|
      create_list :pain_log, 3, pain: pain # has_many
    end
  end
end
