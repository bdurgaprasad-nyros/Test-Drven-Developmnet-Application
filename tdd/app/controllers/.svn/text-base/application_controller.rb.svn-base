require 'uri'
require 'cgi'

class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end


  def after_sign_in_path_for(resource)
    groups_path
  end

  

  def logit(message)

       logger.warn(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
       logger.warn(">>>>>    #{message}")
       logger.warn(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")

   end  

   def logger_manual_debug(msg)
     logit(msg)
   end  

   # time formatters

   def date_to_words(date_value)
     return date_value.strftime("%b %d, %Y") # will print August 12, 2008
   end

   def date_to_slashes(date_value)
     return date_value.strftime("%m/%d/%Y") # will print 5/10/2010

   end  


   # The default url to be used after signing in. This is used by all Devise
   # controllers and you can overwrite it in your ApplicationController to
   # provide a custom hook for a custom resource.
   #
   # By default, it first tries to find a resource_root_path, otherwise it
   # uses the root path. For a user scope, you can define the default url in
   # the following way:
   #
   #   map.user_root '/users', :controller => 'users' # creates user_root_path
   #
   #   map.namespace :user do |user|
   #     user.root :controller => 'users' # creates user_root_path
   #   end
   #
   #
   # If the resource root path is not defined, root_path is used. However,
   # if this default is not enough, you can customize it, for example:
   #
   #   def after_sign_in_path_for(resource)
   #     if resource.is_a?(User) && resource.can_publish?
   #       publisher_url
   #     else
   #       super
   #     end
   #   end
   #
   def after_sign_in_path_for(resource_or_scope)
     scope = Devise::Mapping.find_scope!(resource_or_scope)
     home_index_path
   end
   
   def after_sign_out_path_for(resource_or_scope)
     return root_path
   end
   
   
   
   #### Bunchball code
   
      #  Method for constructing a signature
  	def getSignature time=Time.now.gmtime.to_i.to_s()

  	  user_id = user_signed_in? ? current_user.id : 0

      unencryptedSignature = BUNCHBALL_API_KEY + BUNCHBALL_SECRET_KEY + time.to_s + user_id.to_s
  	  return Digest::MD5.hexdigest(unencryptedSignature + unencryptedSignature.length.to_s())
  	end

  	def log_login()

  	  user_id = user_signed_in? ? current_user.id : 0
  	  first_name = user_signed_in? ? (current_user.first_name.to_s) : "Unknown"
  	  last_name = user_signed_in? ? (current_user.last_name.to_s) : ""
  	  
      ts = Time.now.gmtime.to_i.to_s()
      signature = getSignature(ts)
      request = BUNCHBALL_BASE_URL + "method=user.login" + 
            "&apiKey=" + BUNCHBALL_API_KEY + 
            "&userId=" + user_id.to_s + 
            "&ts=" + ts.to_s + 
            "&firstName=" + first_name + 
            "&lastName=" + last_name + 
            "&sig=" + signature;
            
            
      
      xml_data = Net::HTTP.get_response(URI.parse(request)).body
      doc = REXML::Document.new(xml_data)
      doc.elements.each('Nitro/Login/sessionKey') do |ele|
         session[:Bunchball] = ele.text
      end
  	end

  	# Logs the actions to Bunchball from the server (medium security) API
    # action:  The string with the action name (the convention is OBJECT_VERB e.g. VIEWER_FACEBOOK_SIGNUP)
    # value:   This is the integer value that is the additional parameter that we could assign for the action 
    #          Default is 0. Must be a number. This value is what enables you to create leaderboards, see if user 
    #         has met a certain criteria, and do running total calculations. If this action represents Inviting 
    #         Friends, you could pass a value of 3 in to indicate that the user invited 3 friends. If the action represents Watching a Video, you could pass in the time in seconds that the user watched the video. If the action represents Playing a Game, you could pass in the score.


  	def logAction(actionTag, value=0)

      return if session[:Bunchball].nil? 

  	  user_id = user_signed_in? ? current_user.id : 0
  	  user_name = user_signed_in? ? (current_user.first_name.to_s + " " + current_user.last_name.to_s) : "Unkown"

      ts = Time.now.gmtime.to_i.to_s()


      #need to format what will appear in newsfeed
      @newsfeed = ""
      case actionTag
      when "GROUP_VISIT"
        group = Group.find(value)
        @newsfeed = "visited group <a href=\"#{group.get_group_profile_path}\">#{group.name}</a>"
      when "GROUP_EDIT"
        group = Group.find(value)
        @newsfeed = "edited group <a href=\"#{group.get_group_profile_path}\">#{group.name}</a>"
      when "GROUP_CREATE"
        group = Group.find(value)
        @newsfeed = "created a new group <a href=\"#{group.get_group_profile_path}\">#{group.name}</a>"
      end

       sessionKey = session[:Bunchball]
       @bunchball_request = BUNCHBALL_BASE_URL + 
                "method=user.logAction" + 
                "&sessionKey=" + sessionKey + 
                "&userId="+ user_id.to_s + 
                "&ts=" + ts.to_s + 
                "&tags=" + actionTag + 
                "&value=" + value.to_s
                
       @bunchball_request += "&newsfeed=" + CGI::escape(@newsfeed) if @newsfeed != ""
      
       xml_data = Net::HTTP.get_response(URI.parse(@bunchball_request)).body              

       response = "bad"
       doc = REXML::Document.new(xml_data)           
       doc.elements.each('Nitro') do |ele|
               response = ele.attributes['res']
       end

       if response.eql? "ok"
         return true
       else
         puts xml_data
         return false
       end     
  	end

    def getUserActionFeed(user_id)

       sessionKey = session[:Bunchball]
       
       if (sessionKey.nil?)
         log_login()
         sessionKey = session[:Bunchball]
       end
       
       request = BUNCHBALL_REQUEST_URL + 
                "method=user.getActionHistory" + 
                "&sessionKey=" + sessionKey.to_s + 
                "&userId="+ user_id.to_s

       raw_json_data = Net::HTTP.get_response(URI.parse(request)).body              

       json_data = ActiveSupport::JSON.decode(raw_json_data) 
       
       response = json_data['Nitro']['res']

       if response.eql? "ok"
         return json_data['Nitro']["ActionHistoryRecord"] 
       else
         puts "\njson_data\n#{json_data.inspect}\n"
         return false
       end     
     end


     # Method to get the action feed for many users together (all the users the current user follows)
     # following_user_ids: comma separated list of ids for the users the logged in user follows (up to 100 users in the list)
     # The return data is structured as follows
     # <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
     # <Nitro res="ok" server="gonzo27.bunchball.net/nitro" method="site.getActionFeed">
 	   #    <items>
 		 #      <item lastName="kac" firstName="is" userId="2.2user299" iconUrl="sdgsgsg" ts="1242175037" type="Challenge">sdfsdg</item>
 		 #      <item userId="2.2user501" ts="1242067961" type="Challenge">&lt;a href="/bunchball.com"&gt;2.2user501&lt;/a&gt; loves chocolate</item>
 		 #      <item pointsName="MIOU" price="45" note="yo miuo" recipientLastName="03" recipientFirstName="is" recipientId="ismail03" senderLastName="ghgh" senderId="user250" iconUrl="http://assets.bunchball.net/catalog/AssetsNNThreePianoKeyTie-thumb.swf" ts="1242061853" type="Gift">dfgdfadfasfdasdfasf</item>
 		 #      <item pointsName="pc" price="50" firstName="tou" userId="tofoo" iconUrl="http://assets.bunchball.net/catalog/AssetsTPolympianShortsCargo-thumb.swf" ts="1241759003" type="OwnedItem">efsf</item>
 		 #      <item recipientId="2.2user70" senderId="admin" ts="1241467275" type="Message">asdfsadf</item>
 		 #      <item note="UP" firstName="tou" userId="tofoo" ts="1241740814" type="Level">tofoo just leveled up to c3</item>
 	   #    </items>
     # </Nitro> 
     #
     # Later on we would start creating a user for every group  also and then we could collect the actions for every group
     # by sending the followed group ids along with the user ids followed to this API call

     def getHomeNewsFeed(following_user_ids)

       sessionKey = session[:Bunchball]

       if (sessionKey.nil?)
         log_login()
         sessionKey = session[:Bunchball]
       end

       request = BUNCHBALL_REQUEST_URL + 
                "method=site.getActionFeed" + 
                "&sessionKey=" + sessionKey.to_s + 
                "&userIds="+ following_user_ids +
                "&apiKey=" + BUNCHBALL_API_KEY

       raw_json_data = Net::HTTP.get_response(URI.parse(request)).body              

       json_data = ActiveSupport::JSON.decode(raw_json_data) 

       response = json_data['Nitro']['res']

       if response.eql? "ok"
         return json_data['Nitro']["items"]
       else
         puts "\njson_data\n#{json_data.inspect}\n"
         return false
       end     
     end



      # Adds a user to a group. Creates a new group if it was not created yet.
      # group_id:  The unique identifier for the group
      # user_id:   The user id who started followed the group

     def addUserToGroup(group_id, user_id)

         sessionKey = session[:Bunchball]
         return if sessionKey.nil?
         
         request = BUNCHBALL_BASE_URL + 
                  "method=user.joinGroup" + 
                  "&sessionKey=" + sessionKey + 
                  "&groupName=" + group_id.to_s +
                  "&userId="+ user_id.to_s

         xml_data = Net::HTTP.get_response(URI.parse(request)).body              

         response = "bad"
         doc = REXML::Document.new(xml_data)           
         doc.elements.each('Nitro') do |ele|
                 response = ele.attributes['res']
         end

         if response.eql? "ok"
           return true
         else
           puts xml_data
           return false
         end
      end

      # Removes a user from a group. 
      # group_id:  The unique identifier for the group
      # user_id:   The user id who unfollowed the group

      def removeUserFromGroup(group_id, user_id)

         sessionKey = session[:Bunchball]
         return if sessionKey.nil?

         request = BUNCHBALL_BASE_URL + 
                  "method=user.leaveGroup" + 
                  "&sessionKey=" + sessionKey + 
                  "&groupName=" + group_id.to_s +
                  "&userId="+ user_id.to_s

         xml_data = Net::HTTP.get_response(URI.parse(request)).body              

         response = "bad"
         doc = REXML::Document.new(xml_data)           
         doc.elements.each('Nitro') do |ele|
                 response = ele.attributes['res']
         end

         if response.eql? "ok"
           return true
         else
           puts xml_data
           return false
         end
     end


     # Sets the Facebook connection credentials for a user in bunchball.
     # user_id:   The vChatter user id 
     # facebook_session_key: The user's Facebook session key (from Facebook's pre-OAuth authentication system).
     # facebook_id: The user's Facebook id.
     # facebook_permissions: The user's Facebook permissions (for example, "publish_stream,offline_access").
      def setFacebookStatus(user_id, facebook_session_key, facebook_id, facebook_permissions)

        sessionKey = session[:Bunchball]
        request = BUNCHBALL_BASE_URL + 
                 "method=user.setSocialStatus" + 
                 "&sessionKey=" + sessionKey + 
                 "&facebookSessionKey=" + facebook_session_key +
                 "&facebookId=" + facebook_id.to_s +
                 "&facebookPermissions=" + facebook_permissions +
                 "&userId="+ user_id.to_s

        xml_data = Net::HTTP.get_response(URI.parse(request)).body              

        response = "bad"
        doc = REXML::Document.new(xml_data)           
        doc.elements.each('Nitro') do |ele|
                response = ele.attributes['res']
        end

        if response.eql? "ok"
          return true
        else
          puts xml_data
          return false
        end
     end




    # def getUserPointsBalance
    #        sessionKey = session[:Bunchball]
    #        userName = @userName
    #        @lifeTimeBalance = "NA "
    #        @points = "NA "
    #        request = BUNCHBALL_BASE_URL + "method=user.getPointsBalance" + "&sessionKey=" + session[:Bunchball] + "&start=0" + "&pointCategory=" + BUNCHBALL_POINT_CATEGORY_ALL + "&criteria=" + BUNCHBALL_CRITERIA_CREDITS + "&userId=" + @userName
    #        print "Getting user point balance...\n";
    #        xml_data = Net::HTTP.get_response(URI.parse(request)).body
    #        doc = REXML::Document.new(xml_data)             
    #        doc.elements.each('Nitro/Balance') do |ele|
    #                @lifeTimeBalance = ele.attributes['lifetimeBalance']
    #                @points = ele.attributes['points']
    #        end
    #         print "lifetimeBalance " + @lifeTimeBalance + "\t"
    #         print "points " + @points + "\n"
    # end
    # 
    # def getActionLeaders
    #         sessionKey = session[:Bunchball]
    #         actionTag = @actionTag
    #         @userValue = "NA "
    #         @userId = "NA "
    #         request = BUNCHBALL_BASE_URL + "method=site.getActionLeaders" + "&sessionKey=" + session[:Bunchball] + "&tags=" + @actionTag + "&tagsOperator=" + BUNCHBALL_TAGS_OPERATOR_OR + "&criteria=" + BUNCHBALL_CRITERIA_MAX + "&returnCount=" + @value
    #         print "Getting Action Leaders...\n";
    #         xml_data = Net::HTTP.get_response(URI.parse(request)).body
    #         doc = REXML::Document.new(xml_data)             
    #         doc.elements.each('Nitro/actions/Action') do |ele|
    #                 @userId = ele.attributes['userId']
    #                 @userValue = ele.attributes['value']
    #         end
    #          print @userId + "\t"
    #          print @userValue + "\n"
    #  end

     ###end Bunchball code
   
   
   
     
end
