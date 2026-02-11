# == Schema Information
#
# Table name: exercises
#
#  id                 :bigint           not null, primary key
#  default_per_side   :boolean          default(FALSE)
#  default_rep_length :integer
#  default_reps       :integer
#  default_resistance :string
#  default_sets       :integer
#  description        :text
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :bigint
#
# Indexes
#
#  index_exercises_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

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
    default_resistance { ["", "yellow band", "green band"].sample }
  end

  trait :with_3_exercise_logs do
    after :create do |exercise|
      create_list :exercise_log, 3, exercise: exercise # has_many
    end
  end
end
