class FixProjectsLinksRelation < ActiveRecord::Migration
  def change
    add_column :links, :project_id, :integer
    add_column :projects, :homepage, :string
    add_column :projects, :twitter, :string
    add_column :projects, :facebook, :string

    drop_join_table :links, :projects
    remove_column :links, :name
    remove_column :links, :preview_image
    rename_column :links, :url, :image_id
    rename_table :links, :images
  end
end
