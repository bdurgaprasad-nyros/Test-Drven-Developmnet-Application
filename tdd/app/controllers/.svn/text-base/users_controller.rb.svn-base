class UsersController < ApplicationController
  
  def show 
    @user = User.find(params[:id])
    @user_group = @user.groups.first
    @user_actionfeed = getUserActionFeed(@user.id)
  end
  
  
  def locate
    @user = User.find(params[:id])
    
    if @user.current_group_id > 0
      @current_location = Group.find(@user.current_group_id).get_group_profile_path
    else
      @current_location = @user.get_user_profile_path
    end
    
    respond_to do |format|
      format.js { }
    end

  end
  
end
