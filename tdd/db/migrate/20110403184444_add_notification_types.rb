class AddNotificationTypes < ActiveRecord::Migration
  def self.up
  
      new_notification=NotificationType.create(:name=>"New follower joins group")
      new_notification=NotificationType.create(:name=>"Follower sends message to a group")
      new_notification=NotificationType.create(:name=>"Follower is flagged")
      new_notification=NotificationType.create(:name=>"Received private message")
      
  end

  def self.down
  end
end
