require File.expand_path('../../test_helper.rb', __FILE__)

class SessionsControllerTest < ActionController::TestCase
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
    request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in @user
  end



   ########################################################################
 	 # Edit user data  - fine to put in user controller
 	########################################################################
  test "destroy method" do
    assert @controller.user_signed_in?
    authentication = @user.authentications.create :provider => 'Twitter', :uid => '265602260'
    delete :destroy, :id => authentication
    assert_redirected_to root_url
    assert !@controller.user_signed_in?
  end
end
