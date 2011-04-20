#require 'test_helper'
require File.expand_path('../../test_helper.rb', __FILE__)
require File.expand_path('../../integration_helper.rb', __FILE__)


class UserWorkflowTest < ActionDispatch::IntegrationTest
    
  #include Devise::TestHelpers
  # devise test helpers include...
  #sign_in :user, @user   # sign_in(scope, resource)
  #sign_in @user          # sign_in(resource)
  #sign_out :user         # sign_out(scope)
  #sign_out @user         # sign_out(resource)
      

  ########################################################################
  # SETUP AND HOUSEKEEPING
 	######################################################################## 
  
  fixtures :all


  setup do
    OmniAuth.config.test_mode = true
    @user=User.create(:email => "jojo@test.com", :password => "testing", :first_name=>"JarJar", :last_name => "Beastly")
  end
  ########################################################################
  # TESTS
 	######################################################################## 
  

	 
  ########################################################################
  # basic page load
	######################################################################## 
  test "does new user signup page load" do
    get new_user_registration_path
    assert_response :success
    assert_template "registrations/new"

    v_assert_valid_markup  @response.body

  end

  test "does unvalidated user go to landing page" do

    get root_path
    assert_response :success
    assert_template "welcome/index"

    v_assert_valid_markup  @response.body

  end

  test "does sign-in page load" do
    get new_user_session_path
    assert_response :success
    assert_template "sessions/new"
  end


  ########################################################################
  # REGISTRATION
  #
  #  New user -
  # 	- failed validation
  # 	- signed up with fb token - goes to default group
  # 	- signed up with twitter token - goes to default group
  # 	- signed up with email - goes to default group
  ########################################################################

  test "can user register with twitter" do

  end

  test "can user register with facebook" do

  end


  #### failed validation
  test "make sure user can't register with empty data" do
    post user_registration_path, :user => {}
    assert_response :success
    assert_template :new
    assert_tag  :content =>"Email can't be blank"
    assert_tag  :content =>"Password can't be blank"
    v_assert_valid_markup  @response.body
  end


  test "make user user can't register with bad data" do
    post user_registration_path, :user => {:email => "testtest.com",:password => "prasad",:first_name=>"#fdf",:last_name=>"##455",:date_of_birth=>"41-32-20105"}
    assert_response :success
    assert_template :new
    assert_no_tag  :content =>"Email can't be blank"
    assert_no_tag  :content =>"Password can't be blank"
    assert_tag  :content =>"Email is invalid"
  end

  # signup with email
  test "can user register with good data" do
    post user_registration_path, :user => {:email => "testt@est.com",:password => "prasad",:first_name=>"ggfdf",:last_name=>"fgfdg",:date_of_birth=>"2010-10-10"}

    assert_equal 302, status
    assert_no_tag  :content =>"Email can't be blank"
    assert_no_tag  :content =>"Password can't be blank"
    assert_no_tag  :content =>"Email is invalid"

    user = User.find(:last)

    assert_redirected_to  home_index_path

  end



  test "user must confirm password when registering" do
    post user_registration_path, :user => {:password => "prasad",:password_confirmation => "asdfd"}
    assert_response :success
    assert_template :new
    assert_no_tag  :content =>"Password can't be blank"
    assert_tag  :content =>"Password doesn't match confirmation"
  end

  test "did the user get created upon registration" do
    assert_difference('User.count',1) do
      post  user_registration_path, :user => {:email => "testt@est.com",:password => "prasad",:first_name=>"ggfdf",:last_name=>"fgfdg",:date_of_birth=>"2010-10-10"}
    end
  end


  #############################################################################################
  #Existing user workflow
  #	- sign in form correct password - signs in and goes to default group
  #	- sign in form incorrect - back to sign in with validation
  #	- has Facebook cookie - signins in and goes to default group (see functional authentications)
  # - has Twitter cookie - signins in and goes to default group (see functional authentications)
  #############################################################################################




  test "signin works with correct user info" do
    post user_session_path ,:user=>{:email =>@user.email,:password=>"testing"}
    assert_equal 302, status
    assert_redirected_to  home_index_path
  end

  test "signin failes with incorrect data" do
    post user_session_path ,:user=>{:email =>@user.email,:password => @user.password + "incorrectdata"}
    assert_response  :success
    assert_equal new_user_session_path, path
    assert_template "sessions/new"    # verify path
    assert_equal  "Invalid email or password.",flash[:alert]
  end

  test "user can't login without email" do
    post user_session_path ,:user=>{:email =>"", :password=>@user.password}

    assert_response  :success
    assert_equal new_user_session_path,path
    assert_template "sessions/new"  # verify path
    assert_equal  "Invalid email or password.",flash[:alert]
  end

  test "user can't login without password" do
    post user_session_path ,:user=>{:email =>@user.email, :password=>""}

    assert_response  :success, "unsuccesful login"
    assert_equal new_user_session_path,path
    assert_template "sessions/new"  # verify path
    assert_equal  "Invalid email or password.",flash[:alert]
  end


  test "user can't login with incorrect email address" do
    post user_session_path ,:user=>{:email =>"fatfinger" + @user.email, :password=>@user.password}

    assert_response  :success
    assert_equal new_user_session_path,path
    assert_template "sessions/new" # verify path
    assert_equal  "Invalid email or password.",flash[:alert]
  end

  test "user can't login with blank info submitted" do
    post user_session_path,:user=>{:email =>"",:password=>""}

    assert_response  :success
    assert_equal new_user_session_path,path
    assert_template "sessions/new" # verify path
    assert_equal  "Invalid email or password.",flash[:alert]
  end

  test "unconfirmed user can still login" do
    post user_session_path ,:user=>{:email =>@user.email,:password=>@user.password}

    assert_equal 302, status
    assert_redirected_to  home_index_path

  end



  test "user signout works" do

    new_session_as(@user) do |jojo|
      jojo.logout
    end
  end



  ########################################################################
  # SIGNP workflow - confirmation token from email confirmation
  ########################################################################
  test "valid user confirmation does work" do
    get (user_confirmation_path + "?confirmation_token=" + users(:one).confirmation_token)
    assert_equal 302, status


    assert_redirected_to  home_index_path
  end

  test "invalid confirmation does not work" do
    get (user_confirmation_path + "?confirmation_token=thisbetternotwork")
    assert_response :success
    assert_tag  "Confirmation token is invalid"
    assert_equal user_confirmation_path, path
  end


  test "can user edit information after login" do
    # move to functionals?
    new_session_as(@user) do |jojo|
      jojo.edit_my_profile

      #jojo.assert_tag  :content =>"My Message Nyros Technologies"
      jojo.assert_select  "#user_email[value=#{@user.email}]"
      jojo.assert_select  "#user_first_name[value=#{@user.first_name}]"
      jojo.assert_select  "#user_last_name[value=#{@user.last_name}]"
    end
  end


  ########################################################################
  # Cookie setting (remember me)
  #   	-signs and has indicated remember, then signsin later - taken to default group page
  ########################################################################
  test "does first time facebook user get cookie set and info copies to signup" do
    # confirm that a user registering/ connecing via  facebook gets a cookie set
    new_session do |bobo|
      facebook_data = get_facebook_data
      bobo.login_with_facebook(facebook_data)
      bobo.signup_for_service

      #did user info get copied into form
      bobo.assert_select "#user_email[value=will@whitespaceventures.biz]"
      bobo.assert_select "#user_first_name[value=Will]"
      bobo.assert_select "#user_last_name[value=Bunker]"
      bobo.assert_select "#user_gender_male[checked=checked]"


    end


  end

  test "does first time twitter user get cookie set" do
    new_session do |bobo|
      twitter_data = get_twitter_data
      bobo.login_with_twitter(twitter_data)
    end
    # confirm that a user registering /connecing via  twitter gets a cookie set

  end

  test "does signin with 'remember me' get a cookie set" do
    # confirm that a user signing in, checking "remember" me gets a cookie set


  end

  ########################################################################
  # Pickup up  the "remember me" cookie, or from oath connections
  #   	-take user to default group
  ########################################################################
  test "does returning user with cookie set goto groups page" do
    #As per description above

  end

  ########################################################################
  # forgot password
 	########################################################################

  test "if user forgets to enter email on remmeber password does form return with prompt" do
    post user_password_path  ,:user=>{:email =>nil}
    assert_response :success
    assert_tag  "Email can't be blank"
  end

  test "does forgot password form handle unkown email correctly" do
    post user_password_path  ,:user=>{:email =>"wahtup@user.com"}

    assert_response :success
    assert_tag  "Email not found"
  end

  test "does forgot password form work with known email" do
    post user_password_path  ,:user=>{:email =>@user.email}
    assert_equal 302, status
    assert_redirected_to  new_user_session_path
  end



  ########################################################################
  ## Test cases for add vanity tag to users in edit action by uma mahesh
  ########################################################################


  test "user can add a vanity url for himself" do
    post user_session_path ,:user=>{:email =>@user.email,:password=>"testing"}
    assert_equal 302, status
    assert_redirected_to  home_index_path
    get edit_user_registration_path
    put_via_redirect 'users', :id=> @user.id , :user=>{:email=>"jojo@test.com",:vanity_attributes =>{:tag => "MyString3" } }
    assert_response :success
    assert_template "home/index"
  end

  test "user cannot add a vanity url for another user" do

    new_session do |bobo|
      bobo.signup_for_service
      bobo.post user_registration_path, :id=> @user.id , :user=>{:email=>"umamahesh_nyros1@yahoo.com",:vanity_attributes =>{:tag => "MyVanity" } }
      bobo.assert_response :success, bobo.response.body
      bobo.assert_template "registrations/new"
      bobo.assert_tag "Vanity tag has already been taken"
    end

  end


  ########################################################################
  # Profile basic information workflow
  ########################################################################
  test "when user is logged in and visit basic_iformation then information should display " do
    new_session_as(@user)
    get "/profile/basic_information", :id => @user.id
    assert :sucess
  end

  ########################################################################
  # Helpers/protected
 	########################################################################

  private
   
  module VChatterSessionDSL
     
    attr_accessor :current_user
     
    def login_user(user)
      @current_user = user
      post user_session_path ,:user=>{:email => user.email, :password=>user.password}
  	    
      assert_equal 302, status
      assert_redirected_to  home_index_path
        
      follow_redirect!
        
    end
     
    def edit_my_profile
      get edit_user_registration_path

      assert_template  "registrations/edit"
      v_assert_valid_markup  response.body
    end
      
    def signup_for_service
      get new_user_registration_path
      assert_template  "registrations/new"
    end
      
    def login_with_twitter(user_data)
        
      OmniAuth.config.add_mock(:twitter, user_data)
      get_via_redirect user_omniauth_callback_path(:twitter)
    end
     
    def login_with_facebook(user_data)
      OmniAuth.config.add_mock(:facebook, user_data)
      get_via_redirect user_omniauth_callback_path(:facebook)
    end
      
    def logout
      get destroy_user_session_path
      assert_equal 302, status
      assert_redirected_to  root_path
      follow_redirect!
    end
     
  end


  def new_session
    open_session do |sess|
      sess.extend(VChatterSessionDSL)
      yield sess if block_given?
    end
  end
  
  def new_session_as(user)
    new_session do |sess|
      sess.login_user(user)
      yield sess if block_given?
    end
  end



     
end


