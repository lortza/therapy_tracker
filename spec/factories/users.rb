# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                         :bigint           not null, primary key
#  admin                      :boolean          default(FALSE), not null
#  email                      :string           default(""), not null
#  enable_pt_session_tracking :boolean          default(FALSE)
#  enable_slit_tracking       :boolean          default(FALSE)
#  encrypted_password         :string           default(""), not null
#  first_name                 :string           default(""), not null
#  last_name                  :string           default(""), not null
#  remember_created_at        :datetime
#  reset_password_sent_at     :datetime
#  reset_password_token       :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    sequence(:first_name) { "" }
    sequence(:last_name) { "" }
    # TODO: make email default to ''
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    enable_slit_tracking { false }
    enable_pt_session_tracking { false }
  end
end
