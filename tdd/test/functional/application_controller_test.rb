require File.expand_path('../../test_helper.rb', __FILE__)
require 'socket'

class ApplicationControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
   ########################################################################
 	 # SETUP AND TESTS
 	########################################################################
  
  
  setup do
    @user = users(:one)
    sign_in @user
  end



   ########################################################################
 	 # Edit user data  - fine to put in user controller
 	########################################################################



  test "signature should work" do
    assert_equal "575f90c3584bb78e958cd7ff5c67e524", @controller.getSignature(1301685489)
  end

  test "login should set session" do
    assert_nil session[:Bunchball]
    @controller.log_login
    assert_not_nil session[:Bunchball]
  end
  
  test "log action is successful" do
    
    assert_nil session[:Bunchball]
    @controller.log_login
    assert_not_nil session[:Bunchball]
    
    
    assert @controller.logAction("GROUP_CREATE",1), "Bunchball log action failed, this is most likely due to whitelist of IPs"
    
    #did homefeed get set correctly
    group = Group.find(1)
    assert_equal "created a new group <a href=\"#{group.get_group_profile_path}\">#{group.name}</a>", assigns[:newsfeed]
    
    assert @controller.logAction("GROUP_EDIT",1), "Bunchball log action failed, this is most likely due to whitelist of IPs"
    assert_equal "edited group <a href=\"#{group.get_group_profile_path}\">#{group.name}</a>", assigns[:newsfeed]

    assert @controller.logAction("GROUP_VISIT",1), "Bunchball log action failed, this is most likely due to whitelist of IPs"

    sign_out @user
    user = users(:two)
    sign_in user

    assert @controller.logAction("GROUP_VISIT",1), "Bunchball log action failed, this is most likely due to whitelist of IPs"
    assert_equal "visited group <a href=\"#{group.get_group_profile_path}\">#{group.name}</a>", assigns[:newsfeed]
  end
    
  test "pull user feed is successful" do
    
    assert_nil session[:Bunchball]
    @controller.log_login
    assert_not_nil session[:Bunchball]
    
    user_feed = @controller.getUserActionFeed(1)
    assert user_feed, "Bunchball log action failed, this is most likely due to whitelist of IPs"
    
  end
  
  test "home page feed is successful" do
    sign_out @user
    user = users(:two)
    sign_in user
    
    @controller.log_login
    
    assert_not_nil session[:Bunchball]
    
    bunchball_feed = @controller.getHomeNewsFeed("1,2")
    assert_not_equal false,bunchball_feed , "Bunchball log action failed, this is most likely due to whitelist of IPs"
    
    #puts "\nbunchball_feed=#{bunchball_feed.inspect}\n"
  end
  
    
  test "pull user feed is successful without login" do
    assert @controller.getUserActionFeed(1), "Bunchball log action failed, this is most likely due to whitelist of IPs"
  end
    
    
  test "adding and removing a user to a group" do
    @controller.log_login
    assert @controller.addUserToGroup("1", "1"),"Bunchball log action failed, this is most likely due to whitelist of IPs"
    assert @controller.removeUserFromGroup( "1", "1"), "Bunchball log action failed, this is most likely due to whitelist of IPs"
    
  end
  
end
