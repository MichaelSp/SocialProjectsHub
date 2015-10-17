class CreateJoinTables < ActiveRecord::Migration
  def change
    create_join_table :users, :projects
    create_join_table :projects, :categories
  end
end
