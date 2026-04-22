class CreateSurveyScoreRangeSteps < ActiveRecord::Migration[8.1]
  def change
    create_table :survey_score_range_steps, id: :uuid do |t|
      t.references :survey, null: false, foreign_key: true, type: :uuid
      t.integer :position, null: false
      t.string :name, null: false
      t.text :description
      t.integer :calculated_range_min_points, null: true
      t.integer :calculated_range_max_points, null: true

      t.timestamps
    end
  end
end
