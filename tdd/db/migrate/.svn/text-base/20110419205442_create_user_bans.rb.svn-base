class CreateUserBans < ActiveRecord::Migration
  def self.up
    create_table :user_bans do |t|

      t.integer :user_id
      t.integer :banned_by
      t.integer :group_id
      t.boolean :permanent, :default => false
      t.timestamp :ban_end_time
      
      t.timestamps
    end
    
    add_index :user_bans, :user_id
    add_index :user_bans, :banned_by
    add_index :user_bans, :group_id
    add_index :user_bans, :ban_end_time
    
    
  end

  def self.down
    drop_table :user_bans
  end
end
