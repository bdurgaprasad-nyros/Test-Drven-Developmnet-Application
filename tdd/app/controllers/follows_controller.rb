class FollowsController < ApplicationController
  
  before_filter :authenticate_user!, :include=>[:create,:destroy]
  
  def index
    
  end
  
  def create
    
    tracking_action = ""
    if ["User"].include?(params[:followed_type])
      @user = User.find(params[:followed_id])
      current_user.is_following << @user if current_user.following_relationships.find_by_followed_id_and_followed_type(params[:followed_id], params[:followed_type]).nil?
      @partial_name = 'abandon_user_button'
      tracking_action = "USER_FOLLOW"
    elsif ["Group"].include?(params[:followed_type])
      @group = Group.find(params[:followed_id])
      current_user.groups_followed << @group if current_user.following_relationships.find_by_followed_id_and_followed_type(params[:followed_id], params[:followed_type]).nil?
      @partial_name = 'abandon_group_button'
      tracking_action = "GROUP_FOLLOW"
    end
    
    respond_to do |format|
      format.html {}
      format.js {}
    end
    
    logAction tracking_action, params[:followed_id]
    if ["Group"].include?(params[:followed_type])
      removeUserFromGroup @group.id, current_user.id
    end
    
  end
  
  def destroy
    
    tracking_action = ""
    
    if ["User"].include?(params[:followed_type])
      @partial_name = 'follow_user_button'
      @user = User.find(params[:id])
      tracking_action = "USER_UNFOLLOW"
    elsif ["Group"].include?(params[:followed_type])
      @partial_name = 'follow_group_button'
      @group = Group.find(params[:id])
      tracking_action = "GROUP_UNFOLLOW"
    end
    
    follow_relationship = current_user.following_relationships.find_by_followed_id_and_followed_type(params[:id], params[:followed_type])
    follow_relationship.destroy unless follow_relationship.nil?
    respond_to do |format|
      format.html {}
      format.js {}
    end

    logAction tracking_action, params[:followed_id]
    if ["Group"].include?(params[:followed_type])
      removeUserFromGroup @group.id, current_user.id
    end
  end
  
  
end
