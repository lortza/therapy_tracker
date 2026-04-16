# frozen_string_literal: true

# == Schema Information
#
# Table name: surveys
#
#  id          :uuid             not null, primary key
#  description :text
#  name        :string           not null
#  published   :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :survey do
    sequence(:name) { |n| "survey#{n}" }
    sequence(:description) { |n| "survey#{n} description" }
    published { false }
  end
end
