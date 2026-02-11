class CreateSlitConfigurations < ActiveRecord::Migration[8.1]
  def change
    create_table :slit_configurations, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :max_bottle_doses, null: false
      t.integer :hold_time_seconds, null: false
      t.integer :drops_dose_qty, null: false
      t.timestamps
    end
  end
end
