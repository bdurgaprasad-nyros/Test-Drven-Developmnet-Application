ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  
  
  def v_assert_valid_markup(html)
  
    copy_html = "" << html
    copy_html = cleanup_htmlvalidation(copy_html)
    begin
      assert_valid_markup(copy_html, {:validation_service=>:local})
    rescue
      clipboard_message = copy_response_to_clipboard(copy_html)
      begin
        raise clipboard_message << "\n" << $!
      rescue 
        raise clipboard_message << "\n" << "Couldn't read in the error from assert_valid_markup"
      end
    end
    
    
    
  end

  def v_assert_valid_markup_with_wrapper(html)
  
      copy_html = "" << html
      copy_html = cleanup_htmlvalidation(copy_html)
      wrapper = ""   
      wrapper << "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"
                  \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">
                  <html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\"  >
                 <head><meta http-equiv=\"Content-type\" content=\"text/html;charset=UTF-8\" /><title>Dummy Wrapper</title></head><body>"
      wrapper << copy_of_html
      wrapper << "</body></html>"

    begin
      assert_valid_markup(wrapper)
    rescue
      clipboard_message = copy_response_to_clipboard(wrapper)
      raise clipboard_message + "\n" 
    end
    
    
    
  end

  def copy_response_to_clipboard(response)
    
    if RUBY_PLATFORM =~ /darwin/
      IO.popen('pbcopy', 'w+') {|clipboard| clipboard.write(response)}
      return "assert validate failed and response has been copied to clipboard"
    else
      return ""
      
    end
    
  end  
  
  
  ##using this to remove iframe validation errors
  ##this is not compliant but need for backward compatibility
  def cleanup_htmlvalidation(html)
    
    html.gsub!(/frameborder="0"/,'')
    html.gsub!(/scrolling="(auto|no)"/,'')
    html.gsub!(/allow[tT]ransparency="true"/,'')
    html.gsub!(/<meta.*[\/]>/,'')
    
    
    return html
  end



  def get_twitter_data 
    
    return  {"user_info"=>
      {"name"=>"Will Bunker", 
      "location"=>"San Francisco, CA", 
      "urls"=>{"Website"=>"http://www.yoyobrain.com", "Twitter"=>"http://twitter.com/wbunker"}, 
      "nickname"=>"wbunker", 
      "description"=>"Man on a quest to master art of learning", 
      "image"=>"http://a0.twimg.com/profile_images/88912715/Will_Headshot_normal.jpg"}, 
      "uid"=>"23028943", 
      "credentials"=>{"token"=>"23028943-ruCPFgeyA6U2dJFRxaNWHFOrz5HQAkB5ejkaZ3Dw", "secret"=>"W0tKOhvpDofBsCCzgEBXbpUzBrb7SaQPLCmFOWgdPio"}, 
      "extra"=>
          {"user_hash"=>
              {"profile_background_tile"=>false, 
              "name"=>"Will Bunker", 
              "profile_sidebar_fill_color"=>"E3E2DE", 
              "profile_sidebar_border_color"=>"D3D2CF", 
              "created_at"=>"Fri Mar 06 04:14:31 +0000 2009", 
              "location"=>"San Francisco, CA", 
              "profile_image_url"=>"http://a0.twimg.com/profile_images/88912715/Will_Headshot_normal.jpg", 
              "id_str"=>"23028943", 
              "follow_request_sent"=>false, 
              "profile_link_color"=>"088253", 
              "is_translator"=>false,
               "default_profile"=>false, 
               "favourites_count"=>0, 
               "url"=>"http://www.yoyobrain.com", 
               "contributors_enabled"=>false, 
               "utc_offset"=>-28800, 
               "id"=>23028943, 
               "profile_use_background_image"=>true, 
               "listed_count"=>8, 
               "followers_count"=>58, 
               "protected"=>false, 
               "profile_text_color"=>"634047", 
               "lang"=>"en", 
               "geo_enabled"=>false, 
               "time_zone"=>"Pacific Time (US & Canada)", 
               "profile_background_color"=>"EDECE9", 
               "notifications"=>false, 
               "verified"=>false, 
               "description"=>"Man on a quest to master art of learning", 
               "friends_count"=>15, 
               "statuses_count"=>8, 
               "profile_background_image_url"=>"http://a2.twimg.com/a/1301071706/images/themes/theme3/bg.gif", 
               "default_profile_image"=>false, 
               "status"=>{
                  "coordinates"=>nil, 
                  "created_at"=>"Fri Apr 16 01:31:28 +0000 2010", 
                  "truncated"=>false, 
                  "favorited"=>false, 
                  "id_str"=>"12256506791", 
                  "in_reply_to_user_id_str"=>"811649", 
                  "contributors"=>nil, 
                  "text"=>"@perezd Pantone has several easy guides on Amazon that are quick and useful reads", 
                  "id"=>12256506791, 
                  "retweet_count"=>0, 
                  "in_reply_to_status_id_str"=>"12242121227", 
                  "geo"=>nil, 
                  "retweeted"=>false, 
                  "in_reply_to_user_id"=>811649, 
                  "source"=>"<a href=\"http://itunes.apple.com/app/twitter/id333903271?mt=8\" rel=\"nofollow\">Twitter for iPhone</a>", 
                  "in_reply_to_screen_name"=>"perezd", 
                  "place"=>nil, 
                  "in_reply_to_status_id"=>12242121227}, 
                  "following"=>false, 
                  "screen_name"=>"wbunker", 
                  "show_all_inline_media"=>false
               }
           }, 
      "provider"=>"twitter"}
    
  end
 
  def get_facebook_data 
    return {
      "user_info"=>
         {"name"=>"Will Bunker", "urls"=>{"Facebook"=>"http://www.facebook.com/will.bunker", "Website"=>nil}, 
           "nickname"=>"will.bunker", 
           "last_name"=>"Bunker", 
           "image"=>"http://graph.facebook.com/506658567/picture?type=square", 
           "first_name"=>"Will", 
           "email"=>"will@whitespaceventures.biz"
         }, 
         "uid"=>"506658567", 
         "credentials"=>{"token"=>"203090953052287|b5877dd559441bc406582f85-506658567|5TkDTCLfM0jy-G8hHGg5OlzAMJw"}, 
         "extra"=>{
           "user_hash"=>
             {"name"=>"Will Bunker", 
               "username"=>"will.bunker", 
               "timezone"=>-7, 
               "gender"=>"male", 
               "id"=>"506658567", 
               "last_name"=>"Bunker", 
               "updated_time"=>"2011-03-28T16:33:45+0000", 
               "verified"=>true, 
               "locale"=>"en_US", 
               "hometown"=>{"name"=>nil, "id"=>""}, 
               "link"=>"http://www.facebook.com/will.bunker", 
               "email"=>"will@whitespaceventures.biz", 
               "first_name"=>"Will"
             }
           }, 
           "provider"=>"facebook"
         }
    
  end

  # this is used to make sure 3 avatars with different sizes (plus 1 original image) exists
  def assert_avatar_exists(user)
    assert_not_nil user.avatar_url
    assert_not_nil user.avatar.pic100_100.url
    assert_not_nil user.avatar.pic60_60.url
    assert_not_nil user.avatar.pic30_30.url
    assert File.exists?(user.avatar.current_path)
    assert File.exists?(user.avatar.pic100_100.current_path)
    assert File.exists?(user.avatar.pic60_60.current_path)
    assert File.exists?(user.avatar.pic30_30.current_path)
  end

  # this is used to make sure 3 group images with different sizes (plus 1 original image) exists
  def assert_group_image_exists(group)
    assert_not_nil group.group_image_url
    assert_not_nil group.group_image.pic100_100.url
    assert_not_nil group.group_image.pic60_60.url
    assert_not_nil group.group_image.pic30_30.url
    assert File.exists?(group.group_image.current_path)
    assert File.exists?(group.group_image.pic100_100.current_path)
    assert File.exists?(group.group_image.pic60_60.current_path)
    assert File.exists?(group.group_image.pic30_30.current_path)
  end
  
end
