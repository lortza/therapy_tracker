FactoryBot.define do
  factory :exercise do
    user
    sequence(:name) { |n| "exercise#{n}" }
    sequence(:description) { |n| "description of exercise#{n}" }
  end
end
