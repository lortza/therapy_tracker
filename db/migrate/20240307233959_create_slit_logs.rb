class CreateSlitLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :slit_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :datetime_occurred
      t.boolean :started_new_bottle, default: false
      t.timestamps
    end
  end
end
