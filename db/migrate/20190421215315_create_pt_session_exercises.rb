class CreatePtSessionExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :pt_session_exercises do |t|
      t.references :pt_session, foreign_key: true
      t.references :exercise, foreign_key: true

      t.timestamps
    end
  end
end
