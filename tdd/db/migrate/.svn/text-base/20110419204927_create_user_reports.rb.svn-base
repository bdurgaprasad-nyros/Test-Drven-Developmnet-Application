class CreateUserReports < ActiveRecord::Migration
  def self.up
    create_table :user_reports do |t|
      t.integer :user_id
      t.integer :reported_by
      t.integer :group_id
      t.timestamps
    end
    
    add_index :user_reports, :user_id
    add_index :user_reports, :reported_by
    add_index :user_reports, :group_id
    add_index :user_reports, :created_at
    
    add_column :users, :banned, :boolean, :default => false
    
    execute "update users set banned=0 where banned is null"
    
  end

  def self.down
    drop_table :user_reports
    
    remove_column :users, :banned
  end
end
