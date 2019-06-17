class ChangePtSessionsToPtSessionLogs < ActiveRecord::Migration[5.2]
  def up
    rename_table :pt_sessions, :pt_session_logs
    rename_column :exercise_logs, :pt_session_id, :pt_session_log_id
    rename_column :pt_homework_exercises, :pt_session_id, :pt_session_log_id
  end

  def down
    rename_table :pt_session_logs, :pt_sessions
    rename_column :exercise_logs, :pt_session_log_id, :pt_session_id
    rename_column :pt_homework_exercises, :pt_session_log_id, :pt_session_id
  end
end
