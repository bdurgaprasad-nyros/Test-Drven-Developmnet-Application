class CreateNotificationPreferences < ActiveRecord::Migration
  def self.up
    create_table :notification_preferences do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :frequency_code
      t.timestamps
    end
  end

  def self.down
    drop_table :notification_preferences
  end
end
