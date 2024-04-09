class CreateDummyRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :dummy_records do |t|
      t.text :notes

      t.timestamps
    end
  end
end
