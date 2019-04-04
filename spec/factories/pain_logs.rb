FactoryBot.define do
  factory :pain_log do
    user
    body_part
    datetime_occurred { '2019-03-25 20:15:37' }
    pain
    pain_level { 1 }
    pain_description { 'pain description' }
    trigger { 'pain trigger' }
  end
end
