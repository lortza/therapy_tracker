class RenameSlitDatetimeOccurredToOccurredAt < ActiveRecord::Migration[7.0]
  def up
    rename_column :slit_logs, :datetime_occurred, :occurred_at
  end

  def down
    rename_column :slit_logs, :occurred_at, :datetime_occurred
  end
end
