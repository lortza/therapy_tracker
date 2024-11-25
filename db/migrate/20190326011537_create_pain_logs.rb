# frozen_string_literal: true

class CreatePainLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :pain_logs do |t|
      t.references :user, foreign_key: true
      t.datetime :datetime_occurred
      t.string :target_body_part, default: ""
      t.integer :pain_level
      t.text :pain_description, default: ""
      t.text :trigger, default: ""

      t.timestamps
    end
  end
end
