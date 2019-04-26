class AddStatsToPtSessionExercises < ActiveRecord::Migration[5.2]
  def change
    add_column :pt_session_exercises, :sets, :integer
    add_column :pt_session_exercises, :reps, :integer
    add_column :pt_session_exercises, :resistance, :string
  end
end
