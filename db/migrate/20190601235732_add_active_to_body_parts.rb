class AddActiveToBodyParts < ActiveRecord::Migration[5.2]
  def change
    add_column :body_parts, :archived, :boolean, default: false
  end
end
