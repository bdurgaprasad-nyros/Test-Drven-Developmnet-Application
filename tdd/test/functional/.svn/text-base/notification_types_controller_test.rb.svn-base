require 'test_helper'

class NotificationTypesControllerTest < ActionController::TestCase
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
    get :show, :id => NotificationType.first
    assert_template 'show'
  end

  test "new view should load" do
    get :new
    assert_template 'new'
  end

  test "if new notification type is created with invalid data create should fail" do
    NotificationType.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  test "if new notification type is created with valid data create should pass" do
    NotificationType.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to notification_type_url(assigns(:notification_type))
  end

  test "edit view should load when a notification type is edited" do
    get :edit, :id => NotificationType.first
    assert_template 'edit'
  end

  test "notification type should not be edited with invalid data" do
    NotificationType.any_instance.stubs(:valid?).returns(false)
    put :update, :id => NotificationType.first
    assert_template 'edit'
  end

  test "notification type should be edited with valid data" do
    NotificationType.any_instance.stubs(:valid?).returns(true)
    put :update, :id => NotificationType.first
    assert_redirected_to notification_type_url(assigns(:notification_type))
  end

  test "notification type should be removed from system when deleted" do
    notification_type = NotificationType.first
    delete :destroy, :id => notification_type
    assert_redirected_to notification_types_url
    assert !NotificationType.exists?(notification_type.id)
  end
end
