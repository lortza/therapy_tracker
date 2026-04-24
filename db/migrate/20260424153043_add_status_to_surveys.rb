class AddStatusToSurveys < ActiveRecord::Migration[8.1]
  def change
    add_column :surveys, :status, :integer, default: 0, null: false
  end
end
