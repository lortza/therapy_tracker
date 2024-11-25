class ChangePtSessionTableName < ActiveRecord::Migration[5.2]
  def up
    rename_table :physical_therapy_sessions, :pt_sessions
  end

  def down
    rename_table :pt_sessions, :physical_therapy_sessions
  end
end
