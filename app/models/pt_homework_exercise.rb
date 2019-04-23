class PtHomeworkExercise < ApplicationRecord
  belongs_to :pt_session
  belongs_to :exercise
end
