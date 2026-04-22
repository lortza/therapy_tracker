class CreateSurveyAnswers < ActiveRecord::Migration[8.1]
  def change
    create_table :survey_answers, id: :uuid do |t|
      t.references :survey_response, null: false, foreign_key: true, type: :uuid
      t.references :survey_question, null: false, foreign_key: true, type: :uuid
      t.references :survey_answer_option, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :survey_answers, [:survey_response_id, :survey_question_id], if_not_exists: true
  end
end
