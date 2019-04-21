class SessionExercise < ApplicationRecord
  belongs_to :physical_therapy_session
  belongs_to :exercise
end
