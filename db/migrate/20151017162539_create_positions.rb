class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer :target_group
      t.integer :pos
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
