class DropOldTables < ActiveRecord::Migration[5.2]
  def up
    drop_table :homework_exercises
    drop_table :pt_session_exercises
  end

  def down
    create_table :pt_session_exercises do |t|
      t.references :pt_session, foreign_key: true
      t.references :exercise, foreign_key: true

      t.timestamps
    end

    create_table :homework_exercises do |t|
      t.references :pt_session, foreign_key: true
      t.references :exercise, foreign_key: true

      t.timestamps
    end
  end
end
