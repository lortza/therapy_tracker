# == Schema Information
#
# Table name: pt_homework_exercises
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  exercise_id       :bigint
#  pt_session_log_id :bigint
#
# Indexes
#
#  index_pt_homework_exercises_on_exercise_id        (exercise_id)
#  index_pt_homework_exercises_on_pt_session_log_id  (pt_session_log_id)
#
# Foreign Keys
#
#  fk_rails_...  (exercise_id => exercises.id)
#  fk_rails_...  (pt_session_log_id => pt_session_logs.id)
#

# frozen_string_literal: true

class PtHomeworkExercise < ApplicationRecord
  belongs_to :pt_session_log
  belongs_to :exercise

  validates :pt_session_log, :exercise, presence: true
end
