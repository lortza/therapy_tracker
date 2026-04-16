class CreateSurveyQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :survey_questions, id: :uuid do |t|
      t.references :survey_category, null: false, foreign_key: true, type: :uuid
      t.text :text, null: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end
  end
end
