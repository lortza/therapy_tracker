FactoryBot.define do
  factory :pain_log do
    user
    sequence(:target_body_part) { |n| "Body part#{n}" }
    datetime_occurred { '2019-03-25 20:15:37' }
    pain_level { 1 }
    pain_description { 'pain description' }
    trigger { 'pain trigger' }
  end
end
