# frozen_string_literal: true

class AddDefaultsToExercises < ActiveRecord::Migration[5.2]
  def up
    add_column :exercises, :default_reps, :integer
    add_column :exercises, :default_sets, :integer
    add_column :exercises, :default_rep_length, :integer
  end

  def down
    remove_column :exercises, :default_reps
    remove_column :exercises, :default_sets
    remove_column :exercises, :default_rep_length
  end
end
