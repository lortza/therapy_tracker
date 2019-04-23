class AddDefaultResistanceToExercises < ActiveRecord::Migration[5.2]
  def up
    add_column :exercises, :default_resistance, :string
    add_column :exercise_logs, :resistance, :string
  end

  def down
    remove_column :exercises, :default_resistance
    remove_column :exercise_logs, :resistance
  end
end
