# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    filter_params { params }
    # sequence(:filter_params) { |n| "pain#{n}" }
  end

  params = {
    user: create(:user),
    timeframe: Report::TIMEFRAME.first,
    body_part_id: create(:body_part).id
  }

  # trait :with_3_pain_logs do
  #   after :create do |pain|
  #     create_list :pain_log, 3, pain: pain # has_many
  #   end
  # end
end
