require File.expand_path('../../test_helper.rb', __FILE__)

class FollowsControllerTest < ActionController::TestCase
  include Devise::TestHelpers


  setup do
    @user = users(:one)
    sign_in @user
  end
  
  
  test "can I create a follow relationship" do
    user_to_follow = users(:uma_one)
    assert !(@user.is_following.include?(user_to_follow))
    
    post :create, :followed_id => user_to_follow.id, :followed_type => "User"
    
    @user.reload
    assert (@user.is_following.include?(user_to_follow))
    
  end
  
  test "am I prevented from follow someone twice" do
    user_to_follow = users(:uma_one)
    assert !(@user.is_following.include?(user_to_follow))
    
    post :create, :followed_id => user_to_follow.id, :followed_type => "User"
    
    @user.reload
    assert (@user.is_following.include?(user_to_follow))
 
    post :create, :followed_id => user_to_follow.id, :followed_type => "User"
 
    @user.reload

    followed = @user.is_following.find_all{|user| user == user_to_follow}

    assert_equal 1, followed.length
    
  end
  
  test "can I create a follow relationship with js call" do
    user_to_follow = users(:uma_one)
    assert !(@user.is_following.include?(user_to_follow))
    
    post :create, :format => :js, :followed_id => user_to_follow.id, :followed_type => "User"
    
    @user.reload
    assert (@user.is_following.include?(user_to_follow))
    
    assert_select_rjs :replace_html, "following_message"
    
  end
  
  test "can I destroy follow relationship" do
    
    sign_out @user
    
    user_following = users(:two)
    sign_in user_following
    assert (user_following.is_following.include?(@user))
    
    delete :destroy, :id => @user.id, :followed_type => "User"
    
    user_following.reload
    assert !(user_following.is_following.include?(@user))
    
  end

  test "can I destroy follow relationship with js call and get rjs" do
    
    sign_out @user
    
    user_following = users(:two)
    sign_in user_following
    assert (user_following.is_following.include?(@user))
    
    delete :destroy, :id => @user.id, :followed_type => "User", :format=>:js
    
    user_following.reload
    assert !(user_following.is_following.include?(@user))

    assert_select_rjs :replace_html, "following_message"
    
  end
  
  test "can I create a group follow relationship" do
    group_to_follow = groups(:one)
    assert !(@user.groups_followed.include?(group_to_follow))
    
    post :create, :followed_id => group_to_follow.id, :followed_type => "Group"
    
    @user.reload
    assert (@user.groups_followed.include?(group_to_follow))
    
  end
  
  test "am I prevented from follow group twice" do
    group_to_follow = groups(:one)
    assert !(@user.groups_followed.include?(group_to_follow))
    
    post :create, :followed_id => group_to_follow.id, :followed_type => "Group"
    
    @user.reload
    assert (@user.groups_followed.include?(group_to_follow))
 
    post :create, :followed_id => group_to_follow.id, :followed_type => "Group"
 
    @user.reload

    followed = @user.groups_followed.find_all{|group| group == group_to_follow}

    assert_equal 1, followed.length
    
  end
  
  test "can I create a group follow relationship with js call" do
    group_to_follow = groups(:one)
    assert !(@user.groups_followed.include?(group_to_follow))
    
    post :create, :format => :js, :followed_id => group_to_follow.id, :followed_type => "Group"
    
    @user.reload
    assert (@user.groups_followed.include?(group_to_follow))
    
    assert_select_rjs :replace_html, "following_message"
    
  end
  
  test "can I destroy group follow relationship" do
    
    sign_out @user
    group_followed = groups(:one)
    
    user_following = users(:two)
    sign_in user_following
    assert (user_following.groups_followed.include?(group_followed))
    
    delete :destroy, :id => group_followed.id, :followed_type => "Group"
    
    user_following.reload
    assert !(user_following.groups_followed.include?(group_followed))
    
  end

  test "can I destroy group follow relationship with js call and get rjs" do
    
    sign_out @user
    group_followed = groups(:one)
    
    user_following = users(:two)
    sign_in user_following
    assert (user_following.groups_followed.include?(group_followed))
    
    delete :destroy, :id => group_followed.id, :followed_type => "Group", :format=>:js
    
    user_following.reload
    assert !(user_following.groups_followed.include?(group_followed))

    assert_select_rjs :replace_html, "following_message"
    
  end

end
