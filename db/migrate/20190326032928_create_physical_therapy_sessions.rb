# frozen_string_literal: true

class CreatePhysicalTherapySessions < ActiveRecord::Migration[5.2]
  def change
    create_table :physical_therapy_sessions do |t|
      t.references :user, foreign_key: true
      t.datetime :datetime_occurred
      t.string :target_body_part, default: ""
      t.text :exercise_notes, default: ""
      t.text :homework, default: ""
      t.integer :duration

      t.timestamps
    end
  end
end
