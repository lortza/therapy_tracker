# frozen_string_literal: true

class RemoveTargetBodyPartFromTables < ActiveRecord::Migration[5.2]
  def up
    remove_column :exercise_logs, :target_body_part
    remove_column :pain_logs, :target_body_part
    remove_column :physical_therapy_sessions, :target_body_part
  end

  def down
    add_column :exercise_logs, :target_body_part, :string, default: ''
    add_column :pain_logs, :target_body_part, :string, default: ''
    add_column :physical_therapy_sessions, :target_body_part, :string, default: ''
  end
end
