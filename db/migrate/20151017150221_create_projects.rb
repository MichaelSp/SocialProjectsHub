class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :gps_position
      t.integer :target_group
      t.integer :rating

      t.timestamps null: false
    end
  end
end
