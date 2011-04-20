class CreateNotificationSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :notification_subscriptions do |t|
      t.integer :group_id
      t.integer :user_id
      t.integer :notification_type_id
      t.timestamps
    end
  end

  def self.down
    drop_table :notification_subscriptions
  end
end
