class AddQuestionsToPtSessions < ActiveRecord::Migration[5.2]
  def change
    add_column :pt_sessions, :questions, :text
  end
end
