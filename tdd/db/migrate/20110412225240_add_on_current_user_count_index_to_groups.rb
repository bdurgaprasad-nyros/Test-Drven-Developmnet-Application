class AddOnCurrentUserCountIndexToGroups < ActiveRecord::Migration
  def self.up
    add_index :groups, :current_user_count
  end

  def self.down
    remove_index :groups, :current_user_count
  end
end
