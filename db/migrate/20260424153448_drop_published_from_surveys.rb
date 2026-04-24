class DropPublishedFromSurveys < ActiveRecord::Migration[8.1]
  def change
    remove_column :surveys, :published, :boolean, default: false, null: false
  end
end
