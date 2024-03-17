class AddIndexToPtSessionLogsOccurredAt < ActiveRecord::Migration[7.0]
  def up
    add_index :pt_session_logs, :occurred_at, if_not_exists: true
  end

  def down
    remove_index :pt_session_logs, :occurred_at if index_exists?(:pt_session_logs, :occurred_at)
  end
end
