class AddRecommendedToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :recommended, :boolean, :default=> false
    add_index :groups, :recommended
    
    execute "update groups set recommended=false where recommended is null;"
    
  end

  def self.down
    remove_index :groups, :recommended
    remove_column :groups, :recommended
  end
end
