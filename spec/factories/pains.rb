# == Schema Information
#
# Table name: pains
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_pains_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

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
