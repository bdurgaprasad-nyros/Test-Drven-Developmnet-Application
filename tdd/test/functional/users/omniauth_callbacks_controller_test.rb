require File.expand_path('../../../test_helper.rb', __FILE__)

class Users::OmniauthCallbacksControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  
  test "does calling with existing user add authentication method facebook" do
    
    @user = User.create :email => "test@email.com", :password => "testing"
    @user.confirmed_at = Time.now
    @user.save
    sign_in @user
    
    authentications_count_before=Authentication.count
    
    session[:signup_type] = "AddToExisting"
    
    request.env["omniauth.auth"] = get_facebook_data
    get :facebook
    
    assert_equal "AddToExisting", session[:signup_type]
    assert_equal authentications_count_before+1 , Authentication.count
    
    #assert_equal "goToSignupStep2", assigns[:desired_function]
    
  end
  
  
  test "does calling with existing user add authentication method twitter" do
    
    @user = User.create :email => "test@email.com", :password => "testing"
    @user.confirmed_at = Time.now
    @user.save
    sign_in @user
    
    authentications_count_before=Authentication.count
    
    session[:signup_type] = "AddToExisting"
    
    request.env["omniauth.auth"] = get_twitter_data
    
    get :twitter
    
    assert_equal "AddToExisting", session[:signup_type]
    assert_equal authentications_count_before+1 , Authentication.count
    
    #assert_equal "goToSignupStep2", assigns[:desired_function]
    
  end
  


  test "does calling with email signup type stay email" do
    
    session[:signup_type] = "Email"
    
    request.env["omniauth.auth"] = get_facebook_data
    get :facebook
    
    assert_equal "Email", session[:signup_type]
    assert_equal "goToSignupStep2", assigns[:desired_function]
    
  end

  test "does calling with no signup_type set session to Facebook" do
    
    
    request.env["omniauth.auth"] = get_facebook_data
    get :facebook
    
    assert_equal "Facebook", session[:signup_type]
    assert_equal "pullUpRegistrationDialog", assigns[:desired_function]
    
  end


  test "does adding facebook during email attach authorization to user record" do
    
    user = users(:one)
    sign_in user
    session[:signup_type] = "Email"
    
    request.env["omniauth.auth"] = get_facebook_data
    get :facebook
    
    assert_not_nil user.authentications.find_by_uid("506658567")
  end




end