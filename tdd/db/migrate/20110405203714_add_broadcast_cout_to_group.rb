class AddBroadcastCoutToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :broadcast_count, :integer, :default=>0
    add_column :groups, :current_user_count, :integer, :default=>0
  end

  def self.down
    remove_column :groups, :broadcast_count
    remove_column :groups, :current_user_count
  end
end
