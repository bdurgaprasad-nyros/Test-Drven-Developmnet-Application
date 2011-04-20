class ProfileController < ApplicationController

  before_filter :get_user


  CANNOT_ACCESS_MESSAGE="That's naughty - you don't have access to do that."
  ##################################
  # ACCOUNT INFORMATION 
  ##################################
  
  ##### This method for user can add vanity tag,language code,secret question,time zone settings  as edit view

   def account_settings
    # adding to before filter, remove once tests pass get_user
     return unless user_can_edit
     @user.build_vanity  if @user.vanity.blank?
   end

   ##### This method for user can update vanity tag,language code,secret question,time zone settings

   def account_update
     # adding to before filter, remove once tests pass get_user
     
     return unless user_can_edit

  
    
    # if  !params[:user][:secret_question_code].blank?  && params[:user][:secret_question_answer].blank?
    #   @user.errors.add :secret_question_answer, "can't blank because you are select secret question"
    #   render :action => "account_settings" and return
    # else
  
       @user.update_attributes(params[:user])
      flash[:notice]="Your changes were saved." 
      render :action=>"account_settings"  
       
   end  ## account_update method end


   ##################################
   # (SPORTS AND) ACTIVITIES
   ##################################

     def activities
       @user.build_user_additional_info if @user.user_additional_info.blank?
       
       session[:signup_type] = "AddToExisting"
   		
     end  

     def activities_update
        @user.build_user_additional_info if @user.user_additional_info.blank?
        if user_can_edit
           @user.update_attributes params[:user]
           flash[:notice]="Your changes were saved." 
         else
           flash[:notice] = "Cannot access someone else basic information"
         end

       # RELOADING THE SAME PAGE AFTER UPDATE
       render :action => "activities"
     end


 ##################################
 ###Basic information 
 ##################################
  def basic_information
     # adding to before filter, remove once tests pass get_user
  
    if request.put? and user_can_edit
        @user.update_attributes params[:user]
       flash[:notice]="Your changes were saved." 

    end
  end


  ##################################
  # CONTACT
  ##################################


    def contact_information
       @user.build_instant_messenger_account if @user.instant_messenger_account.blank?
       @user.build_contact_phone if @user.contact_phone.blank?
       # adding to before filter, remove once tests pass get_user

    end

    def contact_information_update
      @user.build_instant_messenger_account if @user.instant_messenger_account.blank?
      @user.build_contact_phone if @user.contact_phone.blank?
      # adding to before filter, remove once tests pass get_user
      if user_can_edit
        @user.update_attributes params[:user]
       flash[:notice]="Your changes were saved." 
      else
        flash[:notice] = "Cannot access someone else basic information"
      end

      # RELOADING THE SAME PAGE AFTER UPDATE
      render :action => "contact_information"

    end


  ##################################
  # IMAGE
  ##################################

    def image
      @this_model = "User"
      @mounted_as = "avatar"
      @this_object_id = current_user.id
      @came_from = "/profile/image"
      @redirect_path = "/profile/image"
      @object=@this_model.classify.constantize.find(@this_object_id.to_i)
      @photo = @object.avatar_url
    end

    def image_update
      @this_model = "User"
      @mounted_as = "avatar"
      @this_object_id = current_user.id
      @came_from = "/profile/image"
      @redirect_path = "/profile/image"
      @object=@this_model.classify.constantize.find(@this_object_id.to_i)
      @photo = @object.avatar_url
      @object.update_attribute(:avatar, params[:file])
       flash[:notice]="Your changes were saved." 
       render :action => "image"
    end


  ##################################
  # INTERESTS 
  ##################################
    def interests
      @user.build_user_additional_info if @user.user_additional_info.blank?
    end
        
    def interests_update
      @user.build_user_additional_info if @user.user_additional_info.blank?
      # adding to before filter, remove once tests pass get_user
      if user_can_edit
        @user.update_attributes params[:user]
        flash[:notice]="Your changes were saved." 
      else
        flash[:notice] = "Cannot access someone else' profile"
      end
      # RELOADING THE SAME PAGE AFTER UPDATE
      render :action => "interests"
    end    
  
  ##################################
  # RELATIONSHIPS
  ##################################


  def relationships
  
      # adding to before filter, remove once tests pass get_user
      return unless user_can_edit

  end

  def relationships_update

      # adding to before filter, remove once tests pass get_user
      return unless user_can_edit


      @user.update_attributes params[:user]
      flash[:notice]="Your changes were saved." 

      # RELOADING THE SAME PAGE AFTER UPDATE
      render :action => "relationships"
  end




##################################
# PHILOSOPHY
##################################

  def philosophy
      # adding to before filter, remove once tests pass get_user

  end

  def philosophy_update
      # adding to before filter, remove once tests pass get_user
      if user_can_edit
        @user.update_attributes params[:user]
       flash[:notice]="Your changes were saved." 
      else
        flash[:notice] = "Cannot access someone else' profile"
      end

    # RELOADING THE SAME PAGE AFTER UPDATE
    render :action => "philosophy"

  end


  def password_update
      # accept users old password, new password and new password confirmation
      # if the old password is correct, update to new password
      if @user.update_with_password(params[:user])
        sign_in(current_user, :bypass => true)
        render :text=> "Your password was successfully updated"
      else
        message = "Change Password Failed :\n"
        @user.errors.full_messages.each do |msg|
          message += "- #{msg}\n"
        end
        render :text=> message
      end
  end  
  
  def deactiviate_account
      # delete the user
     @user = User.find(current_user.id)

       new_feedback =DeletionFeedback.create(:feeedback=>params[:deactivation_feedback]) unless params[:deactivation_feedback].blank?  
       @user.destroy
       
       render :text=>"ok"
       return
       

      
  end  
  
#########HIDDEN AND PROTECTED METHODS  
    hide_action :get_user
    def get_user
        @user=User.find(params[:id]) unless params[:id].blank?
        # else
        if @user.nil? and !current_user.nil?
                @user=current_user
        
        end
        
                   
    end
    
    def user_can_edit
        return true if current_user and @user==current_user
        return false
    end  
      
end
