class AddRolesToUser < ActiveRecord::Migration
  def change
    add_column :users, :roles, :integer, default: 0
  end
end
