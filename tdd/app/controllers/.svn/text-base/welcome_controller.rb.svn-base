class WelcomeController < ApplicationController
  def index
    
    # lookup the user based on the incoming cookie information
    #User.serialize_from_cookie(cookie_string)
    
    if current_user
      @authentications = current_user.authentications
      redirect_to home_index_path
      return
    end
    
    render :layout=> false
  end

  def about_us
  end

  def jobs
  end

  def fans
  end

  def twitter
  end

  def facebook
  end

  def press
  end

  def terms
  end

  def privacy
  end

  def help
  end
  
  def quickstart_guide
  end
  
  def tips
  end
  
  def community_guidelines
  end
  
  def contact_us
  end

end
