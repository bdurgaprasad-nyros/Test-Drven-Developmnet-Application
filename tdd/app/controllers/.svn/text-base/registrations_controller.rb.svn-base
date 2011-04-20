class RegistrationsController < Devise::RegistrationsController

  def create

    build_resource
    session[:omniauth] = nil unless @user.new_record?

    @title_text = "Add Your Facebook Account" << 
      render_to_string(:partial => "shared/more_dialog", :locals=>{:more_id=>"more_2"})
    
    if resource.save
      
      # vanity tag for user
      unless params[:user_vanity_tag].blank?
        vanity=Vanity.create(:tag=>params[:user_vanity_tag], :owner_type=>User, :owner_id=>@user.id)
      end
    
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up
        
        #need to do bunchball action recording
        log_login
        if ["Email"].include?(session[:signup_type])
          logAction("EMAIL_SIGNUP")
        end
          
        respond_to do |format|
          format.js {
            sign_in(resource_name, resource)
            if ["Twitter","Facebook"].include?(session[:signup_type])
              render :update do |page|
                page.redirect_to home_index_path
              end
              
              return
            end
            render
          }
          format.html {
            sign_in_and_redirect(resource_name, resource)
            return
          }
          format.xml { render :xml => @user.to_xml }
        end
        
      else
        set_flash_message :notice, :inactive_signed_up, :reason => resource.inactive_message.to_s
        expire_session_data_after_sign_in!
        redirect_to after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      render_with_scope :new
    end


  end

  def step_2
    @user= current_user
    @this_model = "User"
    @mounted_as = "avatar"
    @this_object_id = @user.id
    @came_from = "registrations"
    respond_to do |format|
      format.html {}
      format.js { }
    end
  end

  def step_3
    @user= current_user
    respond_to do |format|
      format.js {}
      format.html { }
    end
  end


  def new
    
		@agreement_text = "By clicking \"Create Account\" I am agreeing to the <a href=\"/terms\">Terms of Service</a>"
		
		session[:signup_type] = "Email" if  session[:signup_type].nil?
		
		if session[:omniauth]
		  @agreement_text << ", Privacy Policy, and the copying of my #{session[:signup_type]} information into my vChatter profile."
		else
		  @agreement_text << " and Privacy Policy."
    end
    
    
    build_resource
    respond_to do |format|
      format.js { 
        
      }
      format.html
      format.xml { render :xml => @people.to_xml }
    end
    #render :layout=>false
  end

  def edit
    resource.build_vanity  if resource.vanity.blank?
  end

  private

  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth], :verified => true)
    end
  end
end