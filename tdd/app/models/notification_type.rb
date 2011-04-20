class NotificationType < ActiveRecord::Base
  #  attr_accessible :name, :description
  has_many :notification_subscriptions
  has_many :notifications


  # short cut methods to spit out codes 
    def code_for_follower_join
        code=NotificationType.find_by_name("New follower joins group")
        return code.id
    end
    
    def code_for_follower_message_send
          code=NotificationType.find_by_name("Follower sends message to a group")
          return code.id
    end
    
    def code_for_follower_flagged
          code=NotificationType.find_by_name("Followeris flagged")
          return code.id
    end

    
    def code_for_private_message_received
          code=NotificationType.find_by_name("Received private message")
          return code.id
    end


end
