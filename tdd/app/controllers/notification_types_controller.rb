class NotificationTypesController < ApplicationController
  def index
    @notification_types = NotificationType.all
  end

  def show
    @notification_type = NotificationType.find(params[:id])
  end

  def new
    @notification_type = NotificationType.new
  end

  def create
    @notification_type = NotificationType.new(params[:notification_type])
    if @notification_type.save
      redirect_to @notification_type, :notice => "Successfully created notification type."
    else
      render :action => 'new'
    end
  end

  def edit
    @notification_type = NotificationType.find(params[:id])
  end

  def update
    @notification_type = NotificationType.find(params[:id])
    if @notification_type.update_attributes(params[:notification_type])
      redirect_to @notification_type, :notice  => "Successfully updated notification type."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @notification_type = NotificationType.find(params[:id])
    @notification_type.destroy
    redirect_to notification_types_url, :notice => "Successfully destroyed notification type."
  end
end
