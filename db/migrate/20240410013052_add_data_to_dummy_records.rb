class AddDataToDummyRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :dummy_records, :data, :jsonb, default: {}
  end
end
