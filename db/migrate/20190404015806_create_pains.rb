# frozen_string_literal: true

class CreatePains < ActiveRecord::Migration[5.2]
  def change
    create_table :pains do |t|
      t.string :name

      t.timestamps
    end
  end
end
