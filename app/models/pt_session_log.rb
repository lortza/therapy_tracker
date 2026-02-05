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
class PtSessionLog < ApplicationRecord
  extend Log

  belongs_to :user
  belongs_to :body_part
  has_many :exercise_logs, dependent: :destroy

  has_many :pt_homework_exercises, dependent: :destroy
  has_many :homework_exercises, through: :pt_homework_exercises, source: :exercise

  validates :occurred_at,
    :body_part_id,
    :exercise_notes,
    :homework,
    presence: true

  validates :duration,
    presence: true,
    numericality: true

  delegate :name, to: :body_part, prefix: true

  def self.exercise_counts
    output = {}
    all.order(:occurred_at).each do |session|
      output[session.occurred_at.to_date] = session.exercise_logs.count
    end
    output
  end
end
