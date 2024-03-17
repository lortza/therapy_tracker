class AddIndexToPainLogsOccurredAt < ActiveRecord::Migration[7.0]
  def up
    add_index :pain_logs, :occurred_at, if_not_exists: true
  end

  def down
    remove_index :pain_logs, :occurred_at if index_exists?(:pain_logs, :occurred_at)
  end
end
