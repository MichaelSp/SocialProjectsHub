class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :gps_position
      t.integer :target_group
      t.float :rating
      t.integer :position

      t.timestamps null: false
    end
  end
end
