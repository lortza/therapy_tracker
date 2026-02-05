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

class Exercise < ApplicationRecord
  extend Sortable
  extend Searchable

  belongs_to :user
  has_many :exercise_logs, dependent: :destroy
  has_many :logs, class_name: "ExerciseLog", dependent: :destroy, inverse_of: :exercise

  has_many :pt_homework_exercises, dependent: :destroy # the join table
  has_many :pt_homework_sessions, through: :pt_homework_exercises, source: :pt_session_log

  validates :description,
    :default_sets,
    :default_reps,
    :default_rep_length,
    presence: true

  validates :name,
    presence: true,
    uniqueness: {
      case_sensitive: false,
      scope: :user_id
    }

  class << self
    def logs?
      joins(:exercise_logs).group("exercises.id").order(:id)
    end
  end
end
