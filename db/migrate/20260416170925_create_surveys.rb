class CreateSurveys < ActiveRecord::Migration[8.1]
  def change
    create_table :surveys, id: :uuid do |t|
      t.references :user, foreign_key: true, null: true, type: :bigint
      t.string :name, null: false
      t.text :description
      t.boolean :published, null: false, default: false
      t.boolean :available_to_public, null: false, default: false

      t.timestamps
    end
  end
end
