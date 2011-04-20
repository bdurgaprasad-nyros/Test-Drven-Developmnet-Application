require File.expand_path('../../test_helper.rb', __FILE__)

class RegistrationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end


#####putting vanity url for groups at the top for ease of testing, move later
test "create success creates a group " do
  
    test_value="hohoberries" # testing yet just a place holder
    groups_count_before=Group.all.size
    
    session[:signup_type] = "Email"
    
    
    post :create, {:user=> { :email=>"will@goody.com", 
                            :first_name=>"Bobo", 
                            :last_name=>"Yenti", 
                            :password=>"badpassword", 
                            :password_confirmation=>"badpassword" },:user_vanity_tag=>test_value, :format=>:js}
    assert_response :success
    
    assert_equal groups_count_before+1, Group.all.size

end


test "create success relates new group to user" do
  
    test_value="hohoberries" # not testing yet just a place holder
   session[:signup_type] = "Email"
    
    
    post :create, {:user=> { :email=>"will@goody.com", 
                            :first_name=>"Bobo", 
                            :last_name=>"Yenti", 
                            :password=>"badpassword", 
                            :password_confirmation=>"badpassword" },:user_vanity_tag=>test_value, :format=>:js}
    assert_response :success
    
    user=User.find_by_email("will@goody.com")
    assert_not_nil user

    assert_not_nil user.groups
    assert_equal 1, user.groups.size
    
end


test "create success saves vanity correctly for group" do
    
    vanity_count_before=Vanity.all.size
    test_value="hohoberries" # not testing yet just a place holder
   session[:signup_type] = "Email"
    
    
    post :create, {:user=> { :email=>"will@goody.com", 
                            :first_name=>"Bobo", 
                            :last_name=>"Yenti", 
                            :password=>"badpassword", 
                            :password_confirmation=>"badpassword" },:user_vanity_tag=>test_value, :format=>:js}
    assert_response :success
    
    user=User.find_by_email("will@goody.com")
    assert_equal vanity_count_before +1, Vanity.all.size
    assert_not_nil user.vanity
    
    
end



######end vanity url


  test "does have valid html" do
    get :new
    assert_response :success
    v_assert_valid_markup  @response.body
  end
  

  test "does xhr call return new registration correctly" do
    
    get :new, :format=>:js
    assert_response :success
    
    assert_select_rjs :replace_html, "signup_container"
  end


  test "does getting new with facebook data pre-populate" do

    session[:omniauth] = get_facebook_data
    get :new
    assert_response :success
    
    user = assigns[:user]
    assert user.valid?
    
    assert_not_nil user.first_name
    assert_not_nil user.last_name
    
    assert_select "#user_email[value=#{user.email}]"
    assert_select "#user_first_name[value=#{user.first_name}]"
    assert_select "#user_last_name[value=#{user.last_name}]"
    assert_select "#user_gender_male[checked=checked]"
    
  end

  test "user can update profile" do
    ImageUploader.enable_processing = true

    @user = User.create! :email => "test#{rand(20)}@email.com", :password => "testing"
    @user.confirmed_at = Time.now
    @user.save!
    sign_in @user

    post :update, :user => {:first_name => "Vitaly",
                            :last_name => "Dzisyuk",
                            :email => "new@myemail.com",
                            :avatar => fixture_file_upload("flower.jpg", 'image/jpg')
                            }

    @user.reload
    assert_equal "Vitaly", @user.first_name
    assert_equal "Dzisyuk", @user.last_name
    assert_equal "new@myemail.com", @user.email
    assert_avatar_exists(@user)

    @user.remove_avatar!
    ImageUploader.enable_processing = false
  end
  
  
  test "if user grabs new registration without facebook or twitter does it set it to email" do
    get :new
    assert_response :success

    assert_equal "Email", session[:signup_type] 
  end

  test "if user grabs new registration with twitter it doesn't change" do
    
     session[:signup_type] = "Twitter"
    get :new
    assert_response :success

    assert_equal "Twitter", session[:signup_type] 
  end

  test "if user grabs new registration signup_type facebook it doesn't change" do
     session[:signup_type] = "Facebook"
    get :new
    assert_response :success

    assert_equal "Facebook", session[:signup_type] 
  end
  
  test "if user grabs new registration in email path does it set step indicator" do
    get :new
    assert_response :success

    assert_select "#sequence_indicator"
    
    #is step one selected
    assert_select "#sequence_indicator"
    assert_select "#sequence_indicator1.indicator_current"
  end

  test "if user grabs new registration with twitter doesn't show step indicator" do
    
    session[:signup_type] = "Twitter"
    get :new
    assert_response :success

    assert_select "#sequence_indicator", 0
  end

  test "if user grabs new registration signup_type facebook it doesn't show step indicator" do
     session[:signup_type] = "Facebook"
    get :new
    assert_response :success

    assert_select "#sequence_indicator", 0
  end
  
  test "if email session does create go onto to step_2 rjs" do
    
      session[:signup_type] = "Email"
      
      post :create, {:user=> { :email=>"will@goody.to", 
                              :first_name=>"Bobo", 
                              :last_name=>"Yenti", 
                              :password=>"badpassword", 
                              :password_confirmation=>"badpassword" }, :format=>:js}
      assert_response :success
      
      assert_select_rjs :replace_html, "signup_container"
  end

  test "if Twitter session does create close redirect" do
    
      email = "will@goody.to"
      session[:signup_type] = "Twitter"
      
      post :create, {:user=> { :email=>email, 
                              :first_name=>"Bobo", 
                              :last_name=>"Yenti", 
                              :password=>"badpassword", 
                              :password_confirmation=>"badpassword" }}
      
      user = User.find_by_email(email)
      
      assert_redirected_to home_index_path
  end

  test "if Twitter session does create with js does it redirect" do
    
      email = "will@goody.to"
      session[:signup_type] = "Twitter"
      
      post :create, {:user=> { :email=>email, 
                              :first_name=>"Bobo", 
                              :last_name=>"Yenti", 
                              :password=>"badpassword", 
                              :password_confirmation=>"badpassword" }, :format=>:js}
      
      user = User.find_by_email(email)
      assert_equal "window.location.href = \"" + home_index_path + "\";", @response.body
  end

  test "if Facebook session does create close redirect" do
    
      email = "will@goody.to"
      session[:signup_type] = "Facebook"
      
      post :create, {:user=> { :email=>email, 
                              :first_name=>"Bobo", 
                              :last_name=>"Yenti", 
                              :password=>"badpassword", 
                              :password_confirmation=>"badpassword" }, :format=>:js}
      
      user = User.find_by_email(email)
      
      assert_equal "window.location.href = \"" + home_index_path + "\";", @response.body
  end
  
  test "does step 2 render correct step indicator" do
    session[:signup_type] = "Email"
    user = users(:one)
    sign_in user
    
    get :step_2
    
    assert_response :success
    v_assert_valid_markup  @response.body
    
    #is step two selected
    assert_select "#sequence_indicator"
    assert_select "#sequence_indicator2.indicator_current"
    
  end
  
  test "does step 3 render correct step indicator" do
    session[:signup_type] = "Email"
    
    user = users(:one)
    sign_in user
    
    get :step_3
    
    assert_response :success
    v_assert_valid_markup  @response.body
    
    #is step two selected
    assert_select "#sequence_indicator"
    assert_select "#sequence_indicator3.indicator_current"
    
  end

  
end
