class SessionsController < Devise::SessionsController
  
  def new
    super
  end
  
  def create
    super
    log_login
    logAction("EMAIL_SIGNUP")
    
  end
  
  
  def destroy
    user = current_user
    user.forget_me!

    signed_in = signed_in?(resource_name)
    sign_out_and_redirect(resource_name)
    
    instance_variable_set(:"@current_user", nil)
    user = warden.instance_variable_get(:@users).delete(user)
    warden.session_serializer.delete(:user, user)
    
  end
  
  
  
  
end
