class AddIndexToSlitLogsOccurredAt < ActiveRecord::Migration[7.0]
  def up
    add_index :slit_logs, :occurred_at, if_not_exists: true
  end

  def down
    remove_index :slit_logs, :occurred_at if index_exists?(:slit_logs, :occurred_at)
  end
end
