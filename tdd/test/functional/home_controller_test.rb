require File.expand_path('../../test_helper.rb', __FILE__)

class HomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "redirects to root if I am not signed in" do
    get :index
    assert_response :redirect
    assert_redirected_to root_path
  end

  test "does not redirect if not signed in" do
    
    user = users(:one)
    user.groups_followed << groups(:one)
    user.is_following << users(:two)
    
    assert user.groups_followed.count > 0
    
    
    sign_in user
    
    get :index
    assert_response :success
    assert_template "index"
    
    v_assert_valid_markup  @response.body
    
  end

end
