class CreateSurveyEnrollments < ActiveRecord::Migration[8.1]
  def change
    create_table :survey_enrollments, id: :uuid do |t|
      t.references :survey, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :bigint

      t.timestamps
    end

    add_index :survey_enrollments, [:user_id, :survey_id], if_not_exists: true
  end
end
