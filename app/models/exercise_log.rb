# frozen_string_literal: true

# == Schema Information
#
# Table name: exercise_logs
#
#  id                :bigint           not null, primary key
#  burn_rep          :integer
#  burn_set          :integer
#  occurred_at       :datetime
#  per_side          :boolean          default(FALSE)
#  progress_note     :text             default("")
#  rep_length        :integer          default(0)
#  reps              :integer          default(0)
#  resistance        :string
#  sets              :integer          default(0)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  body_part_id      :bigint
#  exercise_id       :bigint
#  pt_session_log_id :bigint
#  user_id           :bigint
#
# Indexes
#
#  index_exercise_logs_on_body_part_id       (body_part_id)
#  index_exercise_logs_on_exercise_id        (exercise_id)
#  index_exercise_logs_on_occurred_at        (occurred_at)
#  index_exercise_logs_on_pt_session_log_id  (pt_session_log_id)
#  index_exercise_logs_on_user_id            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (body_part_id => body_parts.id)
#  fk_rails_...  (exercise_id => exercises.id)
#  fk_rails_...  (pt_session_log_id => pt_session_logs.id)
#  fk_rails_...  (user_id => users.id)
#
class ExerciseLog < ApplicationRecord
  extend Log

  belongs_to :user
  belongs_to :exercise
  belongs_to :body_part
  belongs_to :pt_session_log, optional: true

  validates :occurred_at,
    :exercise_id,
    :body_part_id,
    presence: true

  validates :sets,
    :reps,
    :rep_length,
    presence: true,
    numericality: true

  validates :burn_set,
    :burn_rep,
    presence: {on: :update}

  validates :burn_set,
    :burn_rep,
    numericality: {on: :update}

  delegate :name, to: :body_part, prefix: true
  delegate :name, to: :exercise, prefix: true

  scope :at_home, -> { where(pt_session_log_id: nil) }
  scope :at_pt, -> { where.not(pt_session_log_id: nil) }

  class << self
    def minutes_spent_by_day
      output = {}
      all.find_each do |log|
        occurred = log.occurred_at.to_date

        if output[occurred].nil?
          output[occurred] = log.minutes_spent.round(2)
        else
          output[occurred] += log.minutes_spent.round(2)
        end
      end
      output.sort.to_h
    end
  end

  def seconds_spent
    side_multiplier = per_side ? 2 : 1
    sets * reps * rep_length * side_multiplier
  end

  def minutes_spent
    (seconds_spent.to_f / 60)
  end

  def blank_stats?
    sets.blank? || reps.blank?
  end
end
