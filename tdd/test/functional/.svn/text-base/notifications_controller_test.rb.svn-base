require 'test_helper'

class NotificationsControllerTest < ActionController::TestCase
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
    get :show, :id => Notification.first
    assert_template 'show'
  end

  test "new view should load" do
    get :new
    assert_template 'new'
  end

  test "if new notification is created with invalid data create should fail" do
    Notification.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  test "if new notification is created with valid data create should pass" do
    Notification.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to notification_url(assigns(:notification))
  end

  test "edit view should load when a notification is edited" do
    get :edit, :id => Notification.first
    assert_template 'edit'
  end

  test "notification should not be edited with invalid data" do
    Notification.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Notification.first
    assert_template 'edit'
  end

  test "notification should be edited with valid data" do
    Notification.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Notification.first
    assert_redirected_to notification_url(assigns(:notification))
  end

  test "notification should be removed from system when deleted" do
    notification = Notification.first
    delete :destroy, :id => notification
    assert_redirected_to notifications_url
    assert !Notification.exists?(notification.id)
  end
end
