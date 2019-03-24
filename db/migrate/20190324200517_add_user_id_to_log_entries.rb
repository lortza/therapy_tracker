class AddUserIdToLogEntries < ActiveRecord::Migration[5.2]
  def change
    add_reference :log_entries, :user, foreign_key: true
  end
end
