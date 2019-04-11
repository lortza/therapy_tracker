class AddEachLegToExercises < ActiveRecord::Migration[5.2]
  def change
    add_column :exercises, :default_per_side, :boolean, default: false
    add_column :exercise_logs, :per_side, :boolean, default: false
  end
end
