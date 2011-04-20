require File.expand_path('../../test_helper.rb', __FILE__)

class VanitiesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  
  
  test "should get check_availability" do
    xhr :get, :check_availability, :value_to_check=>"sometag"
    assert_response :success

  end

  test "check_availability should set variable true when vanity available " do
    
    new_tag="hohohoho"
    xhr :get, :check_availability, :value_to_check=>new_tag
    assert_response :success

    assert_equal true, assigns["is_valid"]
  end

  test "check_availability should set variable false unless vanity available " do

    new_tag="hohohoho"
    
    new_vanity=Vanity.create(:tag=>new_tag,  :owner_type=>User, :owner_id=>User.all.first)
    #vanity_count_before=Vanity.all.size
    
    xhr :get,  :check_availability, :value_to_check=>new_tag
    
    assert_response :success

    assert_equal false, assigns["is_valid"]
  end


  test "check_availability should return false if empty string sent" do

    new_tag=""
    
    xhr :get,  :check_availability, :value_to_check=>new_tag
    
    assert_response :success

    assert_equal false, assigns["is_valid"]
  end

  test "check_availability should return false if blank string sent" do

    new_tag=" "
    
    xhr :get,  :check_availability, :value_to_check=>new_tag
    
    assert_response :success

    assert_equal false, assigns["is_valid"]
  end

  test "check_availability should return false if nil sent" do

    
    
    xhr :get,  :check_availability, :value_to_check=>nil
    
    assert_response :success

    assert_equal false, assigns["is_valid"]
  end



  test "show returns blank url if vanity not taken" do
    
    get :show, :vanity_name => "Nonexistent"
    
    assert_response :success
    assert_template :show
    
  end

  test "show returns user show if vanity by user " do
    
    get :show, :vanity_name => vanities(:two).tag
    
    assert_response :success
    assert_template 'users/show'
    
  end

  test "show returns group show if vanity by group" do
    
    get :show, :vanity_name => vanities(:one).tag
    
    assert_response :success
    assert_template 'groups/show'
    
    assert_equal "Group", assigns[:existing_tag].owner_type
    
  end


end
