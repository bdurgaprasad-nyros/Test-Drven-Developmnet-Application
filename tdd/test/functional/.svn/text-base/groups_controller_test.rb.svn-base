require File.expand_path('../../test_helper.rb', __FILE__)

class GroupsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = User.create! :email => "test#{rand(20)}@email.com", :password => "testing"
    @user.save!
    sign_in @user
  end
  
  test "group index loads without login and has valid HTML" do
    get :index
    assert_response :success
    assert_template 'index'
    v_assert_valid_markup   @response.body
    
  end

  test "prove can call recommended page" do
    get :index
    xhr :get, :recommended
    assert_equal "Recommended", assigns(:title)
    assert_equal 2, assigns(:groups).size
    assert_response :success
  end

  test "prove can call most_popular page" do
    get :index
    xhr :get, :most_popular
    assert_equal "Most Popular", assigns(:title)
    assert_equal 3, assigns(:groups).size
    assert_response :success
  end

  test "prove can call most_recent page" do
    get :index
    xhr :get, :most_recent
    assert_equal "Most Recent", assigns(:title)
    assert_equal 3, assigns(:groups).size
    assert_response :success
  end

  test "does show display follow button if you are not following" do
    
    sign_in users(:uma_one)
    
    get :show, :id => groups(:one).id
    assert_select "#start_following"
  end

  test "does show display signup message if you are not logged in" do
    
    sign_out @user
    get :show, :id => groups(:one).id
    assert_response :success
    assert_select ".not_following_button"
    
    v_assert_valid_markup  @response.body
    
  end

  test "does show stop following button if you are following" do
    
    user = users(:two)
    group = groups(:one)
    
    user.groups_followed << group
    
    sign_in users(:two)
    
    
    
    get :show, :id => group.id
    assert_select "#stop_following"
  end





  test "authenticated user can create a group" do
    count_before = Group.all.size
    #TODO please describe what is being done below
    Group.any_instance.stubs(:valid?).returns(true)
    
    post :create
    
    assert_equal (count_before + 1), Group.all.size
    
    
    assert_redirected_to groups_url
  end

  test "unauthenticated user cannot not create a group" do

    count_before = Group.all.size

    sign_out @user
    Group.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_equal (count_before ), Group.all.size

    assert_redirected_to new_user_session_path

  end

  test "groups new loads with valid html" do
    get :new
    assert_template 'new'
    
    assert_response :success
    
     v_assert_valid_markup   @response.body
  end

  test "author can update group" do
    group = @user.groups.build :name => "test group", :description => "this is a test group"
    assert_equal group.save, true
    
    put :update, :id => group
    
    assert_equal 'Successfully updated group.', flash[:notice]
    
    assert_redirected_to groups_path
  end

  test "author  can upload group image to a group he owns" do
    ImageUploader.enable_processing = true
    group_count_before=Group.all.size

    group = @user.groups.build :name=>"this is a test group", :group_image => fixture_file_upload("flower.jpg", 'image/jpg')
    group.save!
    assert_equal group_count_before +1, Group.all.size
    
    assert_equal  true, group.save
    put :update, :id => group
    group.reload
    assert_group_image_exists(group)
    assert_equal 'Successfully updated group.', flash[:notice]
    assert_redirected_to groups_path
    
    group.remove_group_image!
    ImageUploader.enable_processing = false
  end

  test "non-author member cannot update group" do
    put :update, :id => Group.first
    assert_equal 'Access denied.', flash[:error]
    assert_redirected_to root_path
  end

  test "unauthenticated user cannot update group" do
    sign_out @user
    put :update, :id => Group.first
    assert_redirected_to new_user_session_path
    assert_equal 'You need to sign in or sign up before continuing.', flash[:alert]
  end

  test "author can delete his own group" do
    group_count_before=Group.all.size
    group = @user.groups.build :name => "test group", :description => "this is a test group"
    assert_equal group.save, true
    assert_equal group_count_before+1, Group.all.size
    delete :destroy, :id => group
    assert_equal group_count_before, Group.all.size

    assert_equal 'Successfully destroyed group.', flash[:notice]
    assert_redirected_to groups_path
  end

  test "nonauthor cannot delete someones else group" do
    group_count_before=Group.all.size
    delete :destroy, :id => Group.first
    
    assert_equal 'Access denied.', flash[:error]
    assert_equal group_count_before, Group.all.size
    assert_redirected_to root_path
  end

  test "non logged in user tries to delete some group" do
    sign_out @user
    group = Group.first
    delete :destroy, :id => group.id
    assert_redirected_to new_user_session_path
    assert_equal 'You need to sign in or sign up before continuing.', flash[:alert]
    
    assert_not_nil Group.find(group.id)
  end
########################################################################
 	## Test cases for add vanity tag to groups  in edit action by uma mahesh
 	########################################################################
  test "should not get edit" do
    get :edit, :id =>groups(:three)
    assert_response  302
    assert_redirected_to root_path
  end

	test "should edit own group" do
    create_group
    get :edit, :id =>@group
    
    assert_response :success
    assert_template 'groups/edit'

    v_assert_valid_markup   @response.body
    
  end


	test "user can not add a vanity url for a group he has not created" do
    create_group
    put :update, :id =>groups(:three)
    assert_equal 'Access denied.', flash[:error]
  end

  test "user can add a vanity url for a group he has created" do
    create_group
    put :update, :id => @group.id  , :group=>{:name=>"test_group",:description=>"test description",:vanity_attributes =>{:tag => "MyString5" } }
    assert_response 302
    assert_response :redirect
    assert_redirected_to groups_url
    assert_equal 'Successfully updated group.', flash[:notice]
    assert  assigns(:group)
    assert_equal  "test_group",assigns(:group).name
  end

  test "user can not add a duplicate vanity url for a group" do
    create_group
    put :update, :id => @group.id  , :group=>{:name=>"test_group",:description=>"test description",:vanity_attributes =>{:tag => "MyString" } }
    assert_response :success
    assert_template "groups/edit"

    v_assert_valid_markup   @response.body

    assert_tag "Vanity tag has already been taken"

  end

  test "user can update group's notification subscriptions" do
    create_group
    put :update, :id => @group.id, :group=>{:name=>"test_group", :description=>"test description",
                                   :notification_type_ids =>["3", "2", "4"]}
    @group.reload
    assert_redirected_to groups_url
    assert_equal 'Successfully updated group.', flash[:notice]
    assert_equal 3, @group.notification_subscriptions.size
    assert_equal [2,3,4], @group.notification_subscriptions.collect(&:notification_type_id).sort
    assert_equal [@user.id], @group.notification_subscriptions.collect(&:user_id).uniq

    #delete some subscriptions
    put :update, :id => @group.id, :group=>{:name=>"test_group", :description=>"test description",
                                   :notification_type_ids =>["3", "1"]}
    @group.reload
    assert_redirected_to groups_url
    assert_equal 'Successfully updated group.', flash[:notice]
    assert_equal 2, @group.notification_subscriptions.size
    assert_equal [1,3], @group.notification_subscriptions.collect(&:notification_type_id).sort
    assert_equal [@user.id], @group.notification_subscriptions.collect(&:user_id).uniq
  end

  test "user can update group's notification preference" do
    create_group
    put :update, :id => @group.id, :group=>{:name=>"test_group", :description=>"test description",
                                   :notification_preference_attributes =>{"user_id"=>@user.id, "frequency_code"=>"3"}}
    @group.reload
    assert_redirected_to groups_url
    assert_equal 'Successfully updated group.', flash[:notice]
    assert_equal @user.id, @group.notification_preference.user_id
    assert_equal @group.id, @group.notification_preference.group_id
    assert_equal 3, @group.notification_preference.frequency_code
  end


  test "can update group count" do
    
    group = groups(:one)
    b_count = 10
    c_count = 15
    
    post :update_count, :id => group.id, :broadcast_count=>b_count, :current_user_count => c_count, :secret=>'dkkd2342c29x'
    
    assert_response :success
    
    group.reload
    assert_equal b_count, group.broadcast_count
    assert_equal c_count, group.current_user_count
    
  end

  test "can update broadcast count" do
    
    group = groups(:one)
    b_count = 30
    
    post :update_count, :id => group.id, :broadcast_count=>b_count, :secret=>'dkkd2342c29x'
    
    assert_response :success
    
    group.reload
    assert_equal b_count, group.broadcast_count
    
  end

  test "can update current user count" do
    
    group = groups(:one)
    c_count = 30
    
    post :update_count, :id => group.id, :current_user_count=>c_count, :secret=>'dkkd2342c29x'
    
    assert_response :success
    
    group.reload
    assert_equal c_count, group.current_user_count
    
  end

  test "can set user in a room" do
    
    group = groups(:one)
    user = users(:one)
    
    assert_not_equal group.id, user.current_group_id
    post :update_count, :id => group.id, :user_id=>1,:user_action=>"entering", :secret=>'dkkd2342c29x'
    
    assert_response :success
    
    user.reload
    assert_equal group.id, user.current_group_id
    
  end

  test "can set user out of a room" do
    
    group = groups(:one)
    user = users(:one)
    user.current_group_id = 1
    user.save
    
    assert_equal group.id, user.current_group_id
    post :update_count, :id => group.id, :user_id=>1,:user_action=>"leaving", :secret=>'dkkd2342c29x'
    
    assert_response :success
    
    user.reload
    assert_equal 0, user.current_group_id
    
  end

  test "can set to broadcasting room" do
    
    group = groups(:one)
    user = users(:one)
    
    assert_not_equal group.id, user.current_group_id
    assert_not_equal true, user.is_broadcasting

    post :update_count, :id => group.id, :user_id=>1,:user_action=>"start_broadcasting", :secret=>'dkkd2342c29x'
    
    assert_response :success
    
    user.reload
    assert_equal group.id, user.current_group_id
    assert_equal true, user.is_broadcasting
    
  end

  test "can set to not broadcasting room" do
    
    group = groups(:one)
    user = users(:one)
    user.current_group_id = 0
    user.is_broadcasting = true
    user.save;
    
    post :update_count, :id => group.id, :user_id=>1,:user_action=>"stop_broadcasting", :secret=>'dkkd2342c29x'
    
    assert_response :success
    
    user.reload
    assert_equal group.id, user.current_group_id
    assert_equal false, user.is_broadcasting
    
  end

  test "what happens when bad user id passed" do
    
    group = groups(:one)
    
    post :update_count, :id => group.id, :user_id=>5000,:user_action=>"stop_broadcasting", :secret=>'dkkd2342c29x'
    
    assert_response :success
    
    
  end

  protected

  def create_group
    #assert_difference('Group.count') do
    @group = @user.groups.build :name => "test group", :description => "this is a test group"
    @group.save
    #end
    #assert_response :success
  end

end
