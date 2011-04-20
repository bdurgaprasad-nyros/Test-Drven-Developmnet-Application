require 'test_helper'

class NotificationSubscriptionsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = User.create :email => "test@email.com", :password => "testing"
    @user.confirmed_at = Time.now
    @user.save
    @omniauth = YAML::load(File.open("#{Rails.root}/test/omniauth.yml"))
    request.env["omniauth.auth"] = @omniauth
    sign_in @user
  end
  
  test "index view should load" do
    get :index
    assert_template 'index'
  end

  test "show view should load" do
    get :show, :id => NotificationSubscription.first
    assert_template 'show'
  end

  test "new view should load" do
    get :new
    assert_template 'new'
  end

  test "if new notification subscription is created with invalid data create should fail" do
    NotificationSubscription.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  test "if new notification subscription is created with valid data create should pass" do
    NotificationSubscription.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to notification_subscription_url(assigns(:notification_subscription))
  end

  test "edit view should load when a notification subscription is edited" do
    get :edit, :id => NotificationSubscription.first
    assert_template 'edit'
  end

  test "notification subscription should not be edited with invalid data" do
    NotificationSubscription.any_instance.stubs(:valid?).returns(false)
    put :update, :id => NotificationSubscription.first
    assert_template 'edit'
  end

  test "notification subscription should be edited with valid data" do
    NotificationSubscription.any_instance.stubs(:valid?).returns(true)
    put :update, :id => NotificationSubscription.first
    assert_redirected_to notification_subscription_url(assigns(:notification_subscription))
  end

  test "notification subscription should be removed from system when deleted" do
    notification_subscription = NotificationSubscription.first
    delete :destroy, :id => notification_subscription
    assert_redirected_to notification_subscriptions_url
    assert !NotificationSubscription.exists?(notification_subscription.id)
  end
end
