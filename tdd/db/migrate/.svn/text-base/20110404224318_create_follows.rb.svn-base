class CreateFollows < ActiveRecord::Migration
  def self.up
    create_table :follows do |t|
      t.integer :followed_id, :following_id
      t.string :followed_type, :following_type
      t.timestamps
    end
  end

  def self.down
    drop_table :follows
  end
end
