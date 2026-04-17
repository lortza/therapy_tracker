class CreateSurveyAnswerOptions < ActiveRecord::Migration[8.1]
  def change
    create_table :survey_answer_options, id: :uuid do |t|
      t.references :survey, null: false, foreign_key: true, type: :uuid
      t.integer :value, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
