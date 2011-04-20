require File.expand_path('../../test_helper.rb', __FILE__)

class PhotoControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = User.create! :email => "test#{rand(20)}@email.com", :password => "testing"
    @user.confirmed_at = Time.now
    @user.save!
    sign_in @user
  end

  test "user can set avatar" do
    ImageUploader.enable_processing = true

    assert_nil @user.avatar_url
    post :set_image, {:model=>"user",:mounted_as=>"avatar", :file=> fixture_file_upload("flower.jpg", 'image/jpg'), :object_id => @user.id, :came_from => "registrations"}

    @user.reload
    assert_avatar_exists(@user)
    assert_response :success

    @user.remove_avatar!
    ImageUploader.enable_processing = false
  end

  test "prove user avatar is copied for personal group when user update his avatar" do
    ImageUploader.enable_processing = true

    assert_nil @user.avatar_url
    post :set_image, {:model=>"user",
                      :mounted_as=>"avatar", 
                      :file=> fixture_file_upload("flower.jpg", 'image/jpg'), 
                      :object_id => @user.id, 
                      :came_from => "registrations"}

    @user.reload
    assert_avatar_exists(@user)
    group = @user.groups.where(:personal => true).first
    assert_not_nil group.group_image_url
    assert File.exists?(group.group_image.current_path)
    assert_response :success

    @user.remove_avatar!
    group.remove_group_image!
    ImageUploader.enable_processing = false
  end

  test "should be able to upload profile image from 'My Profile'" do
    ImageUploader.enable_processing = true
    profile_image_path = "/profile/image"

    assert_nil @user.avatar_url
    post :set_image, {:model=>"user",
                      :mounted_as=>"avatar",
                      :file=> fixture_file_upload("flower.jpg", 'image/jpg'),
                      :object_id => @user.id,
                      :came_from => profile_image_path,
                      :redirect_path => profile_image_path
                     }

    @user.reload
    assert_avatar_exists(@user)
    assert_response :success

    @user.remove_avatar!
    ImageUploader.enable_processing = false
  end


  test "get new_photo_form" do
    get :new_photo_iframe, {:model=>"user",:mounted_as=>"avatar", :object_id => @user.id}
    assert_response :success
    v_assert_valid_markup  @response.body
  end

  test "get new_photo_iframe" do
    get :new_photo_iframe, {:model=>"user",:mounted_as=>"avatar", :object_id => @user.id}
    assert_response :success
    v_assert_valid_markup  @response.body  
  end

end
