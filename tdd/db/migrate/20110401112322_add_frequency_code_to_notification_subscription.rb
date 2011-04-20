class AddFrequencyCodeToNotificationSubscription < ActiveRecord::Migration
  def self.up
	add_column :notification_subscriptions, :frequency_code, :string
  end

  def self.down
	remove_columd :notification_subscriptions, :frequency_code
  end
end
