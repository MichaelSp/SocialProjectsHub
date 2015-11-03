class RenameImageIdToFileId < ActiveRecord::Migration
  def change
    rename_column :images, :image_id, :file_id
  end
end
