# frozen_string_literal: true

# == Schema Information
#
# Table name: pt_session_logs
#
#  id             :bigint           not null, primary key
#  duration       :integer
#  exercise_notes :text             default("")
#  homework       :text             default("")
#  occurred_at    :datetime
#  questions      :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  body_part_id   :bigint
#  user_id        :bigint
#
# Indexes
#
#  index_pt_session_logs_on_body_part_id  (body_part_id)
#  index_pt_session_logs_on_occurred_at   (occurred_at)
#  index_pt_session_logs_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (body_part_id => body_parts.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :pt_session_log do
    user
    body_part
    occurred_at { "2019-03-25 22:29:28" }
    questions { "sample question?" }
    exercise_notes { "sample exercise notes" }
    homework { "sample homework" }
    duration { [45, 60, 90].sample }
  end

  trait :with_homework_exercise do
    after :create do |pt_session_log|
      create :homework_exercise, pt_session_log: pt_session_log, exercise: create(:exercise)
    end
  end
end
