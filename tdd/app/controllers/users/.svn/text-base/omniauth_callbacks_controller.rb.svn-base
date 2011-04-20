class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook


    if ["Email"].include?(session[:signup_type])
      @desired_function = "goToSignupStep2"
    
    elsif  ["AddToExisting"].include?(session[:signup_type])     
      @desired_function = "addFacebookToAccountList"
     
      @desired_url="/profile/account_settings"
    else
      session[:signup_type] = "Facebook" 
      @desired_function = "pullUpRegistrationDialog"
    end
    
    
    handle_omniauth
    
  end
  

  def twitter
  
    if  ["AddToExisting"].include?(session[:signup_type])     
      @desired_function = "addTwitterToAccountList"
      @desired_url="/profile/account_settings"
      
    else
      session[:signup_type] = "Twitter"
      @desired_function = "pullUpRegistrationDialog"
    
    end
      handle_omniauth 
  

  end
  

  private 
  def handle_omniauth
    
    #Get the context
    omniauth_callback_data =  request.env["omniauth.auth"]
    
    #if we are already logged in then we are attaching this to existing user
    if user_signed_in?
      current_user.authentications.create(:provider => omniauth_callback_data['provider'], :uid => omniauth_callback_data['uid'])
      return
    end
      
      
    #not logged in  
    previous_authentication_credentials = Authentication.find_by_provider_and_uid(omniauth_callback_data['provider'], omniauth_callback_data['uid'])

    ############################################
    # don't have this user from before
    ############################################
    if  !previous_authentication_credentials or (previous_authentication_credentials and !previous_authentication_credentials.user)
      
      if session[:signup_type] == "Twitter"
        session[:omniauth] = omniauth_callback_data.except('extra')
      elsif session[:signup_type] == "Facebook"
        session[:omniauth] = omniauth_callback_data
      end
      # mutant case of no user but leftover credentials
      previous_authentication_credentials.destroy if previous_authentication_credentials
      
      if ["Facebook","Twitter"].include?(session[:signup_type])
        bunchball_action = session[:signup_type].upcase + "_SIGNUP"
        logAction(bunchball_action)
      end
      
    ############################################
    # known user logging back in
    ############################################
    else
      sign_in :user, previous_authentication_credentials.user
      @desired_url= home_index_path
      flash[:notice] = 'Authentication successful.'
      log_login

      if ["Facebook","Twitter"].include?(session[:signup_type])
        bunchball_action = session[:signup_type].upcase + "_LOGIN"
        logAction(bunchball_action)
      end
      
    end
    
  end
  
  
  

end
