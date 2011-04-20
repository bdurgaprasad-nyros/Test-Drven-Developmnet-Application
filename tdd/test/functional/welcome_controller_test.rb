require File.expand_path('../../test_helper.rb', __FILE__)

class WelcomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  
  setup do
    @user = User.create :email => "test@email.com", :password => "testing"
    @user.confirmed_at = Time.now
    @user.save
    @omniauth = YAML::load(File.open("#{Rails.root}/test/omniauth.yml"))
    request.env["omniauth.auth"] = @omniauth
    
  end

  test "should get index" do
    get :index
    assert_response :success
    v_assert_valid_markup  @response.body
  end
  
  test "index reroutes to" do
    
    user_count_before=User.all.size
    user = User.new( :email => "test2@email.com", :password => "testing", :password_confirmation => "testing")
    user.save!
    assert_equal (user_count_before + 1) , User.all.size
    
    sign_in @user

    get :index
    
    assert_redirected_to home_index_path
    
  end

  test "should get about_us" do
    get :about_us
    assert_response :success
    v_assert_valid_markup  @response.body
  end

  test "should get jobs" do
    get :jobs
    assert_response :success
    v_assert_valid_markup  @response.body
  end

  test "should get fans" do
    get :fans
    assert_response :success
    v_assert_valid_markup  @response.body
  end

  test "should get twitter" do
    get :twitter
    assert_response :success
    v_assert_valid_markup  @response.body
  end

  test "should get facebook" do
    get :facebook
    assert_response :success
    v_assert_valid_markup  @response.body
  end

  test "should get press" do
    get :press
    assert_response :success
    v_assert_valid_markup  @response.body
  end

  test "should get terms" do
    get :terms
    assert_response :success
    v_assert_valid_markup  @response.body
  end

  test "should get privacy" do
    get :privacy
    assert_response :success
    v_assert_valid_markup  @response.body
  end

  test "should get help" do
    get :help
    assert_response :success
    v_assert_valid_markup  @response.body
  end
  
  
  

end
