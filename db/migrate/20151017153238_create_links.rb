class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.string :name
      t.string :preview_image
      t.string :category

      t.timestamps null: false
    end

    create_join_table :links, :projects
  end
end
