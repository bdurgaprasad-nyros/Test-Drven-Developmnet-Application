class HomeController < ApplicationController
  def index
    
    #this is only for signed in users
    if ! user_signed_in?
      redirect_to root_path 
      return
    end
    
    followed_ids = current_user.following_user_relationships.map{ |following| following.id }
    @newsfeed = getHomeNewsFeed(followed_ids.join(","))
    
    
    @following_info = current_user.is_following.map{|followed|      { :id => followed.id, 
                                                                        :image => User.get_user_pic(followed,"60_60"),
                                                                        :type => "VChatter",
                                                                        :name=>followed.full_name}}
                                                                        
    @following_info = [] if @following_info.nil?
    
    #fake ones to test with
    @newsfeed = getHomeNewsFeed("1")
    
  end

end
