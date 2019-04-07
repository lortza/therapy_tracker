# frozen_string_literal: true

class AddPainToTables < ActiveRecord::Migration[5.2]
  def change
    add_reference :pain_logs, :pain, foreign_key: true
    add_reference :pain_logs, :body_part, foreign_key: true
    add_reference :exercise_logs, :body_part, foreign_key: true
    add_reference :physical_therapy_sessions, :body_part, foreign_key: true
    add_reference :pains, :user, foreign_key: true
    add_reference :body_parts, :user, foreign_key: true
  end
end
