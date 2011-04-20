require File.expand_path('../../test_helper.rb', __FILE__)


class ProfileControllerTest < ActionController::TestCase
  include Devise::TestHelpers


  
######TEST SETUP#########

  setup do
    
    
    @user = User.create :email => "test@email.com", :password => "testing"
    @user.confirmed_at = Time.now
    @user.save
    sign_in @user
  end

  ##############################################################################
  ## ACCOUNT SETTINGS/RELATED
  ##############################################################################
  test "should get account settings page with valid html" do
    get :account_settings
    assert_response :success
    v_assert_valid_markup  @response.body
  end


  test "get account settings shows correct template" do
    get :account_settings
    assert_response :success
    assert_template "profile/account_settings"

  end



  test "user can  save his own account settings" do

    vanity="hotnewurl"
    secret_question_code=1  
    secret_question_answer = "nonyabusiness" 
    language_code=3
    time_zone_code= "Pacific Time (US & Canada)"  

  
    
    # ensure these are not already the values
    assert_not_equal vanity, @user.vanity
    assert_not_equal secret_question_code, @user.secret_question_code
    assert_not_equal secret_question_answer, @user.secret_question_answer
    assert_not_equal language_code, @user.language_code
    assert_not_equal time_zone_code, @user.time_zone
    
    # submit changes
    put :account_update, :id => @user.id ,
      :user=> {  :secret_question_code => secret_question_code , 
              :secret_question_answer => secret_question_answer,
              :language_code=> language_code,
              :time_zone=> time_zone_code,
              :vanity_attributes=>{:tag=>vanity}
              }

    assert_response :success
    assert_template "profile/account_settings"
    
    # test to see whether values saved
    @user.reload
    assert_equal vanity, @user.vanity.tag
    assert_equal secret_question_code, @user.secret_question_code
    assert_equal secret_question_answer, @user.secret_question_answer
    assert_equal language_code, @user.language_code
    assert_equal time_zone_code, @user.time_zone   

  end



  # TODO 
  #cannot load someone elses when logged in
  # cannot load someone elses not logged in 
  # cannot update some else when logged in
  # cannot update someone else when not logged in

  ##############################################################################
  ## ACTIVITIES 
  ##############################################################################
  test "prove profile activities loads with valid html" do
    get :activities
    assert_response :success
    v_assert_valid_markup  @response.body
  end

  test "prove user can update ones own profile activities" do
      
      sports="softball, baseball, football"
      favorite_teams="man u, mudville sluggers"
      favorite_athletes="ricky bobby,  hoho spagnola"
      other_activities="something, another thing, and that too"
        
      # verify these are not the current values  
      assert_not_equal sports, @user.sports
      assert_not_equal favorite_teams, @user.teams
      assert_not_equal favorite_athletes, @user.athletes
      assert_not_equal other_activities, @user.other_activities
      
      post :activities_update,:id => @user.id ,
           :user=> {:user_additional_info_attributes =>
             {:sports=> sports,
              :teams=>favorite_teams,
              :athletes=>favorite_athletes,
              :other_activities=>other_activities
             }
           }
       
      assert_response :success
      
      # prove that the values saved
      @user.reload

      assert_equal sports, @user.sports
      assert_equal favorite_teams, @user.teams
      assert_equal favorite_athletes, @user.athletes
      assert_equal other_activities, @user.other_activities


   end




  # TODO 
  #cannot load someone elses when logged in
  # cannot load someone elses when not logged in 
  # cannot update some else when logged in
  # cannot update someone elses when  not logged in


  ##############################################################################
  ## BASIC INFORMATION
  ##############################################################################


    test "prove profile basic information loads with valid html" do
      get :basic_information
      assert_response :success
      v_assert_valid_markup  @response.body
    end


    test "prove user can update his own basic information" do
      
      # setup test values
      home_town="lahore"
      current_town="armani town" 
      interested_in_code="3"
      bio="I am so very biographical, you have no idea how biographical I am."
   
      #verify the user does not current have test values
      assert_not_equal home_town, @user.home_town 
      assert_not_equal current_town, @user.current_town
      assert_not_equal interested_in_code, @user.interested_in_code
      assert_not_equal bio, @user.bio
   
      put :basic_information, :id => @user.id, :user=> { 
          :home_town => home_town, 
          :current_town => current_town , 
          :interested_in_code => interested_in_code,
           :bio => bio}

      # verify that we saved information
      assert_response :success

      @user.reload
      assert_equal  home_town, @user.home_town 
      assert_equal  current_town, @user.current_town
      assert_equal  interested_in_code, @user.interested_in_code
      assert_equal  bio, @user.bio

    end





  ##############################################################################
  ## CONTACT INFROMATION
  ##############################################################################

  test "prove contact information loads with valid html" do
    get :contact_information
    assert_response :success
    v_assert_valid_markup  @response.body
  end



  test "prove user can update contact information" do    
    contact_phone_count = ContactPhone.count
    instant_messenger_count = InstantMessengerAccount.count
  
    street_address="12123 easy street"
    city="happytown"
    state="tx"
    zip_code="12331"
    contact_phone="1231231234"
    screen_name="rudyttudy"
    service_code= 1

    assert_not_equal street_address, @user.street_address
    assert_not_equal city, @user.city
    assert_not_equal state, @user.state
    assert_not_equal zip_code, @user.zip_code
    assert_not_equal screen_name, @user.instant_messenger_account.screen_name
    assert_not_equal service_code, @user.instant_messenger_account.service_code
    assert_not_equal contact_phone, @user.contact_phone.phone_number
    
    put :contact_information_update, :id => @user.id ,
        :user=> {  
             :street_address => street_address,
             :city => city,
             :state => state,
             :zip_code => zip_code,
             :contact_phone_attributes => {:phone_number => contact_phone},
             :instant_messenger_account_attributes => {:screen_name => screen_name, :service_code => service_code}
         }
    
    assert_response :success
    @user.reload

    assert_equal street_address, @user.street_address
    assert_equal city, @user.city
    assert_equal state, @user.state
    assert_equal zip_code, @user.zip_code
    assert_equal screen_name, @user.instant_messenger_account.screen_name
    assert_equal service_code, @user.instant_messenger_account.service_code
    assert_equal contact_phone, @user.contact_phone.phone_number

    assert_equal contact_phone_count + 1, ContactPhone.count
    assert_equal instant_messenger_count + 1, InstantMessengerAccount.count

  end  

  # TODO 
  # can update his own (values save to correct location)
  #cannot load someone elses when logged in
  # cannot load someone elses not logged in 
  # cannot update some else when logged in
  # cannot update someone else when not logged in



  ##############################################################################
  ## IMAGE
  ##############################################################################



    test "profile image loads with valid markup" do
      get :image
      assert_response :success
      v_assert_valid_markup  @response.body
    end

    test "prove user can update image" do
      ImageUploader.enable_processing = true

      assert_nil @user.avatar_url
      post :image_update, :model =>"User",
        :model =>"User",
        :mounted_as =>"avatar",
        :preview =>"1", 
        :object_id =>@user.id,
        :came_from=>"/profile/image",
        :file => fixture_file_upload("flower.jpg", 'image/jpg')
      @user.reload
      assert_avatar_exists(@user)

      @user.remove_avatar!
      ImageUploader.enable_processing = false
    end

    # TODO 
    # can update his own (values save to correct location)
    #cannot load someone elses when logged in
    # cannot load someone elses not logged in 
    # cannot update some else when logged in
    # cannot update someone else when not logged in



    ##############################################################################
    ##INTERESTS
    ##############################################################################
    test "prove profile interests loads with valid html" do
      get :interests
      assert_response :success
      v_assert_valid_markup  @response.body
    end
    
    test "prove user can update his own profile interests" do
    
          music="softball, baseball, football"
          books="man u, mudville sluggers"
          movies="ricky bobby,  hoho spagnola"
          television="something, another thing, and that too"
          games="something, another thing, and that too"
          other="something, another thing, and that too"
          
          # make sure these are not already the values
          assert_not_equal music, @user.music
          assert_not_equal books, @user.books
          assert_not_equal movies, @user.movies
          assert_not_equal games, @user.games
          assert_not_equal other, @user.other
    
          post :interests_update,:id => @user.id,
            :user=> {"user_additional_info_attributes" => 
                      { :music=>music,
                        :books=>books,
                        :movies=>movies,
                        :games=>games,
                        :other=>other
                      } 
                    }
    
          assert_response :success
          @user.reload
          
          
          #assert that the values saved
          assert_equal music, @user.music
          assert_equal books, @user.books
          assert_equal movies, @user.movies
          assert_equal games, @user.games
          assert_equal other, @user.other
    
    
    
      end

    # TODO 
    #cannot load someone elses when logged in
    # cannot load someone elses not logged in 
    # cannot update some else when logged in
    # cannot update someone else when not logged in





  ##############################################################################
  ## PHILOSOPHY and RELIGION
  ##############################################################################


  test "philosophy loads with valid html" do
    get :philosophy
    assert_response :success
    v_assert_valid_markup  @response.body
  end

  test "user can update his own philosophy" do
      
      religion="Positivity"
      religion_description="be positive. anything else is negative."  
      political_view="HoHoBerries"
      political_description="The HoHoBerry Party has all of the answers. magically.  Like if you vote for them you are always right. and if you don't you are always wrong."

       # make sure these are not already the values
       assert_not_equal religion, @user.religion
       assert_not_equal religion_description, @user.religion_description
       assert_not_equal political_view, @user.political_view
       assert_not_equal political_description, @user.political_view_description

      put :philosophy_update, :id => @user.id ,:user=> {  
        :religion => religion, 
        :religion_description => religion_description, 
        :political_view => political_view, 
        :political_view_description => political_description
      }
    
       assert_response :success
       # test that the values saved
       @user.reload
       assert_equal  religion, @user.religion
       assert_equal  religion_description, @user.religion_description
       assert_equal  political_view, @user.political_view
       assert_equal  political_description, @user.political_view_description
    
  end
  # TODO 
  #cannot load someone elses when logged in
  # cannot load someone elses not logged in 
  # cannot update some else when logged in
  # cannot update someone else when not logged in
  
  ##############################################################################
  ## RELATIONSHIPS
  ##############################################################################


    test "profile relationships loads with valid html" do
      get :relationships, {:id => @user.id}
      assert_response :success
      v_assert_valid_markup  @response.body
    end

    test "prove user can update his own relationship status" do
      
      
      new_code=1
      
      
      assert_not_equal new_code, @user.relationship_status_code
      
      put :relationships_update, :id => @user.id ,:user=> {  :relationship_status_code => 1 }
      
      assert_response :success
      @user.reload
      assert_equal new_code, @user.relationship_status_code
    
    
    end

    # TODO 
   
    #cannot load someone elses when logged in
    # cannot load someone elses not logged in 
    # cannot update some else when logged in
    # cannot update someone else when not logged in
    
    
    test "prove user can update password with valid current password" do
      old_encrypted_password = @user.encrypted_password
      post :password_update, :user=>{:current_password => "testing", :password=>"123123", :password_confirmation=>"123123"}
      assert_equal false, assigns(:user).errors[:current_password].any?
      assert_equal 0, assigns(:user).errors.size

      @user.reload
      assert_not_equal old_encrypted_password, @user.encrypted_password
      assert_response :success
    end

    test "prove user cannot update password with invalid current password" do
      old_encrypted_password = @user.encrypted_password
      post :password_update, :user=>{:current_password => "hohoho", :password=>"123123", :password_confirmation=>"123123"}
      assert_equal true, assigns(:user).errors[:current_password].any?
      assert_not_equal 0, assigns(:user).errors.size

      @user.reload
      assert_equal old_encrypted_password, @user.encrypted_password
      assert_response :success
    end



  test "prove user account can be deactivated" do
    assert_difference('User.count', -1) do
      xhr :post, :deactiviate_account, :id => @user.id
    end
    
    assert_response :success    
    
  end

  test "prove that feedback is saved user account can be deactivated" do
    
    feedback_count_before=DeletionFeedback.count
    assert_difference('User.count', -1) do
      xhr :post, :deactiviate_account, :id => @user.id, :deactivation_feedback=>"i dunno"
    end
    
    assert_response :success    
    assert_equal feedback_count_before + 1, DeletionFeedback.count
    
  end
  



  
    
end
