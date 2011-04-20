class GroupsController < ApplicationController

  before_filter :authenticate_user!, :only=>[:create, :edit,:new,:update,:destroy]
  load_and_authorize_resource
  protect_from_forgery :except => ['update_count']
  
  def index
    @groups=Group.get_more_recommended_groups
    @title="Recommended"
  end

# actions for browse groups
# these can be dry'd out later
  def most_recent
    
    @groups=Group.get_most_recent_groups
    @title="Most Recent"
    
  end  

  def most_popular
    @groups=Group.get_trending_groups
    @title="Most Popular"

  end  
  
  def recommended
      @groups=Group.get_more_recommended_groups
      @title="Recommended"    
  end  
  
# end browse actions  

  def show
    @group=Group.find(params[:id])
    @user_id =  user_signed_in? ? current_user.id : (-1* rand(10000))
    @user_name = user_signed_in? ? current_user.full_name : 'Anonymous'
    
    @user_pic_url =  User.get_user_pic(current_user,"30_30")

    @is_admin = user_signed_in? ? ( (@group.user_id == current_user.id) ? "true" : "false" ) : "false"
    @is_super_admin = user_signed_in? ? ( (current_user.is_super_admin?) ? "true" : "false" ) : "false"
    @is_logged_in = user_signed_in? ? "true" : "false"
    
    render
    logAction("GROUP_VISIT",@group.id)
    
    
  end

  def create
    @group = current_user.groups.new(params[:group])
    if @group.save
      @group.notification_types.update_all(:user_id => current_user.id) unless @group.notification_types.size == 0
      redirect_to groups_url, :notice => "Successfully created group."
      logAction("GROUP_CREATE",@group.id)
      
    else
      render :action => 'new'
    end
  end

  def new
    @group = current_user.groups.new(params[:group])
    @group.build_vanity  if  @group.vanity.blank?
    @group.build_notification_preference if @group.notification_preference.blank?
  end

  def edit
    @group=Group.find(params[:id])
    @group.build_vanity  if  @group.vanity.blank?
    @group.build_notification_preference if @group.notification_preference.blank?
    
    render
    
    logAction("GROUP_EDIT",@group.id)
    
  end

  def update
    if @group.update_attributes(params[:group])
      @group.notification_types.update_all(:user_id => current_user.id) unless @group.notification_types.size == 0
      flash[:notice]="Successfully updated group."
  
      redirect_to groups_url
      #redirect_to :controller=>"groups", :action=>"edit",:id=>@group.id  
    else
      render :action => 'edit'
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url, :notice => "Successfully destroyed group."
  end


  def update_count
    
    return unless ["dkkd2342c29x"].include?(params[:secret])
    
    group = Group.find(params[:id])
    
    unless group.nil?
      group.current_user_count = params[:current_user_count] unless params[:current_user_count].blank?
      group.broadcast_count = params[:broadcast_count]  unless params[:broadcast_count].blank?
      group.save
    end
    
    unless params[:user_id].blank?
      
      begin
        user = User.find(params[:user_id])

        case params[:user_action]
          when "entering"
            user.current_group_id=group.id
          when "leaving"
            user.current_group_id=0
            user.is_broadcasting = false
          when "start_broadcasting"
            user.is_broadcasting = true
            user.current_group_id=group.id
          when "stop_broadcasting"
            user.current_group_id=group.id
            user.is_broadcasting = false
        end
        user.save
      rescue
        #do nothing
      end
    end
    
    respond_to do |format| 
      format.html { head :ok}
    end
    
  end

end
