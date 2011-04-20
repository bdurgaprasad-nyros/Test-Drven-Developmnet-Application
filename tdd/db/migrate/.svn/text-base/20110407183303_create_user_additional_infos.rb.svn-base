class CreateUserAdditionalInfos < ActiveRecord::Migration
  def self.up
    create_table :user_additional_infos do |t|
      t.integer :user_id
      t.string :sports
      t.string :teams
      t.string :athletes
      t.string :music
      t.string :books
      t.string :movies
      t.string :television
      t.string :games
      t.string :other
      t.string :other_activities
      t.timestamps
    end
    
    add_index :user_additional_infos, :user_id, :unique => true
    
    execute "insert into user_additional_infos (user_id) select id from users"
    
  end

  def self.down
    drop_table :user_additional_infos
  end
end
