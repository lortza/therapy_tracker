class CreateSurveyScoreRanges < ActiveRecord::Migration[8.1]
  def change
    create_table :survey_score_ranges, id: :uuid do |t|
      t.references :survey, null: false, foreign_key: true, type: :uuid
      t.integer :range_min_value, null: false
      t.integer :range_max_value, null: false
      t.string :name

      t.timestamps
    end
  end
end
