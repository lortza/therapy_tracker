class AddPtSessionIdToExerciseLogs < ActiveRecord::Migration[5.2]
  def change
    add_reference :exercise_logs, :pt_session, foreign_key: true
  end
end
