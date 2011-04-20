class NotificationPreferencesController < ApplicationController
  # GET /notification_preferences
  # GET /notification_preferences.xml
  def index
    @notification_preferences = NotificationPreference.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notification_preferences }
    end
  end

  # GET /notification_preferences/1
  # GET /notification_preferences/1.xml
  def show
    @notification_preference = NotificationPreference.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @notification_preference }
    end
  end

  # GET /notification_preferences/new
  # GET /notification_preferences/new.xml
  def new
    @notification_preference = NotificationPreference.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @notification_preference }
    end
  end

  # GET /notification_preferences/1/edit
  def edit
    @notification_preference = NotificationPreference.find(params[:id])
  end

  # POST /notification_preferences
  # POST /notification_preferences.xml
  def create
    @notification_preference = NotificationPreference.new(params[:notification_preference])

    respond_to do |format|
      if @notification_preference.save
        format.html { redirect_to(@notification_preference, :notice => 'Notification preference was successfully created.') }
        format.xml  { render :xml => @notification_preference, :status => :created, :location => @notification_preference }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @notification_preference.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /notification_preferences/1
  # PUT /notification_preferences/1.xml
  def update
    @notification_preference = NotificationPreference.find(params[:id])

    respond_to do |format|
      if @notification_preference.update_attributes(params[:notification_preference])
        format.html { redirect_to(@notification_preference, :notice => 'Notification preference was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @notification_preference.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notification_preferences/1
  # DELETE /notification_preferences/1.xml
  def destroy
    @notification_preference = NotificationPreference.find(params[:id])
    @notification_preference.destroy

    respond_to do |format|
      format.html { redirect_to(notification_preferences_url) }
      format.xml  { head :ok }
    end
  end
end
