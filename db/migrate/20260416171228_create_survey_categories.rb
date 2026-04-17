class CreateSurveyCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :survey_categories, id: :uuid do |t|
      t.references :survey, null: false, foreign_key: true, type: :uuid
      t.string :name, null: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end
  end
end
