require File.expand_path('../../test_helper.rb', __FILE__)

class UsersControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "does show work" do
    get :show, :id => users(:one).id
    
    v_assert_valid_markup  @response.body
    assert_response :success
    
  end
  
  test "does show display follow button if you are not following" do
    
    sign_in users(:uma_one)
    
    get :show, :id => users(:one).id
  
    v_assert_valid_markup  @response.body
  
    assert_select "#start_following"
    
  end

  test "does show display signup message if you are not logged in" do
    get :show, :id => users(:one).id
    
    v_assert_valid_markup  @response.body
    assert_select ".not_following_button"
  end

  test "does show stop following button if you are following" do
    
    sign_in users(:two)
    
    get :show, :id => users(:one).id
    v_assert_valid_markup  @response.body
    assert_select "#stop_following"
  end

end
