# == Schema Information
#
# Table name: body_parts
#
#  id         :bigint           not null, primary key
#  archived   :boolean          default(FALSE)
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_body_parts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

# frozen_string_literal: true

FactoryBot.define do
  factory :body_part do
    user
    sequence(:name) { |n| "body_part#{n}" }
    archived { false }
  end
end
