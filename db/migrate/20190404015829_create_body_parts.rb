class CreateBodyParts < ActiveRecord::Migration[5.2]
  def change
    create_table :body_parts do |t|
      t.string :name

      t.timestamps
    end
  end
end
