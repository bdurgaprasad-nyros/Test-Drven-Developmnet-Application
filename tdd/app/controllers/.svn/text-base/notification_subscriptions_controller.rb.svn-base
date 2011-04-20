class NotificationSubscriptionsController < ApplicationController
  def index
    @notification_subscriptions = NotificationSubscription.all
  end

  def show
    @notification_subscription = NotificationSubscription.find(params[:id])
  end

  def new
    @notification_subscription = NotificationSubscription.new
  end

  def create
    @notification_subscription = NotificationSubscription.new(params[:notification_subscription])
    if @notification_subscription.save
      redirect_to @notification_subscription, :notice => "Successfully created notification subscription."
    else
      render :action => 'new'
    end
  end

  def edit
    @notification_subscription = NotificationSubscription.find(params[:id])
  end

  def update
    @notification_subscription = NotificationSubscription.find(params[:id])
    if @notification_subscription.update_attributes(params[:notification_subscription])
      redirect_to @notification_subscription, :notice  => "Successfully updated notification subscription."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @notification_subscription = NotificationSubscription.find(params[:id])
    @notification_subscription.destroy
    redirect_to notification_subscriptions_url, :notice => "Successfully destroyed notification subscription."
  end
end
