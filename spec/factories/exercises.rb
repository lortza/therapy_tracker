# frozen_string_literal: true

FactoryBot.define do
  factory :exercise do
    user
    sequence(:name) { |n| "exercise#{n}" }
    sequence(:description) { |n| "description of exercise#{n}" }
    default_sets { 2 }
    default_reps { 10 }
    default_rep_length { 5 }
    default_per_side { false }
    default_resistance { ['', 'yellow band', 'green band'].sample }
  end

  trait :with_3_exercise_logs do
    after :create do |exercise|
      create_list :exercise_log, 3, exercise: exercise # has_many
    end
  end
end
