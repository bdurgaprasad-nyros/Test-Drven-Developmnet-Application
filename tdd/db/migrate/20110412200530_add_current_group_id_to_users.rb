class AddCurrentGroupIdToUsers < ActiveRecord::Migration
  def self.up
      add_column :users, :current_group_id, :integer
      add_column :users, :is_broadcasting, :boolean, :default=>false
      
      add_index :users, :current_group_id
      
      
      execute "update users set is_broadcasting=false where is_broadcasting is null;"
    end

    def self.down
      remove_index :users, :current_group_id
      remove_column :users, :current_group_id
      remove_column :users, :is_broadcasting
  end
end
