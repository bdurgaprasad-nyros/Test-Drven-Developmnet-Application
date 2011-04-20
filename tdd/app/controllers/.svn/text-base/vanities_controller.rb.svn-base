class VanitiesController < ApplicationController

  def check_availability
    ## accepts a text string, checks for the presence of that string vanity
    
    value_to_check=params[:value_to_check]
    if value_to_check.blank? 
      @is_valid=false 
      return
    end  
    @existing_tag=Vanity.find_by_tag(value_to_check)
  
    @is_valid=( @existing_tag.nil? and not params[:value_to_check].blank? ) ? true : false 

    
  end
  
  
  def show
    
    @existing_tag=Vanity.find_by_tag(params[:vanity_name])
    
    if @existing_tag.nil?
      render
    elsif @existing_tag.owner_type == "User"
      @user = @existing_tag.owner
      @user_group = @user.groups.first
      @user_actionfeed = getUserActionFeed(@user.id)
      render 'users/show'
    elsif @existing_tag.owner_type == "Group"
      @group = @existing_tag.owner
      @user_id =  user_signed_in? ? current_user.id : (-1* rand(10000))
      @user_name = user_signed_in? ? current_user.full_name : 'Anonymous'
      @user_pic_url =  User.get_user_pic(current_user,"30_30")
      @is_admin = user_signed_in? ? ( (@group.user_id == current_user.id) ? "true" : "false" ) : "false"
      @is_super_admin = user_signed_in? ? ( (current_user.is_super_admin?) ? "true" : "false" ) : "false"
      @is_logged_in = user_signed_in? ? "true" : "false"
      
      
      render 'groups/show'
      logAction("GROUP_VISIT",@group.id)
      
    end
    
    
    
  end

end
