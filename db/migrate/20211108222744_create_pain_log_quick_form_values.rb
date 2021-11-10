# frozen_string_literal: true

class CreatePainLogQuickFormValues < ActiveRecord::Migration[6.1]
  def change
    create_table :pain_log_quick_form_values do |t|
      t.references :user, foreign_key: true
      t.references :body_part, foreign_key: true
      t.references :pain, foreign_key: true
      t.string :name, null: false
      t.integer :pain_level
      t.text :pain_description
      t.text :trigger
      t.timestamps
    end
  end
end
