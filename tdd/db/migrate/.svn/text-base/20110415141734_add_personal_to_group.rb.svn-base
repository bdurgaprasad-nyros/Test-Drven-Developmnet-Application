class AddPersonalToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :personal, :boolean, :default => false
  end

  def self.down
    remove_column :groups, :personal
  end
end
