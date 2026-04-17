class CreateSurveyResponses < ActiveRecord::Migration[8.1]
  def change
    create_table :survey_responses, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :bigint
      t.references :survey, null: false, foreign_key: true, type: :uuid
      t.datetime :occurred_at, null: false
      t.text :notes
      t.integer :total_score, null: false, default: 0

      t.timestamps
    end
    add_index :survey_responses, [:user_id, :survey_id, :occurred_at], if_not_exists: true
  end
end
