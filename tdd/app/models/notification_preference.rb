class NotificationPreference < ActiveRecord::Base
  #At present this is for frequencies
  
  belongs_to :user  # who does this belong to
  belongs_to :group # what group it is for
  
  
  # VALUES FOR THE FREQUENCY
  DAILY_FREQUENCY_CODE=1
  WEEKLY_FREQUENCY_CODE=2
  MONTHLY_FREQUENCY_CODE=3
  
  
  

end
