require File.expand_path('../../test_helper.rb', __FILE__)

class AuthenticationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
   ########################################################################
 	 # SETUP AND TESTS
 	########################################################################
  
  
  setup do
    @user = User.create :email => "test@email.com", :password => "testing"
    @user.confirmed_at = Time.now
    @user.save
    @omniauth = YAML::load(File.open("#{Rails.root}/test/omniauth.yml"))
    request.env["omniauth.auth"] = @omniauth
    sign_in @user
  end



   ########################################################################
 	 # Edit user data  - fine to put in user controller
 	########################################################################



  test "index view should load" do
    get :index
    assert_response :success
  end

  
end
