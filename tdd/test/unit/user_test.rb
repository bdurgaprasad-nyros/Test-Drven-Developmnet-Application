require File.expand_path('../../test_helper.rb', __FILE__)

class UserTest < ActiveSupport::TestCase

  test "user should not save upon blank submission" do
    user = User.new
    assert_equal user.save, false
  end

  test "user should not save if email is nil" do
    u = User.create(:password => "testing")
    
    assert u.errors[:email]
  end

  test "user should not save if password is nil" do
    u = User.create(:email => "email@test.com")
    assert u.errors[:password]
  end

  test "user should save if email and password are given" do
    u = User.create(:email => "email@test.com", :password => "testing")
    assert u.errors.empty?
    assert_not_nil u.id
  end

  test "user should be non verifyied when created" do
    u = User.create(:email => "email@test.com", :password => "testing")
    assert_nil u.confirmed_at
  end

  test "user should require confirmation to be set when creating a new record" do
    user = User.new(:password => 'new_password', :password_confirmation => 'blabla')
    assert user.new_record?
    assert !user.valid?
    assert user.errors[:password]
    assert_equal 'doesn\'t match confirmation', user.errors[:password].join
  end

  test "user should require a password with minimum of 6 characters" do
   	user = User.new(:password => '12345', :password_confirmation => '12345')
    assert user.new_record?
    assert !user.valid?
    assert user.errors[:password]
    assert_equal 'is too short (minimum is 6 characters)', user.errors[:password].join
  end

  test "user should accept valid emails" do
    %w(abc@example.com test_mail@gmail.com any@any.net email@test.br 123@mail.test).each do |email|
      user = User.new(:email => email)
      assert !user.valid?, 'should be valid with email ' << email
      assert_blank user.errors[:email]
    end
  end

  test "user should ensure uniqueness of email" do
    user = User.new(:email => "sdgdfg@gmail.com" ,:FirstName => "Franky",:LastName => "Med",:password => "testing",
      :password_confirmation => "testing",:date_of_birth => "2011-03-02")
    assert user.new_record?
    assert user.valid?
    assert user.save
  end

  test "user should accept valid date" do
    user = User.new(:email => "sdgdfg@gmail.com" ,:FirstName => "Franky",:LastName => "Med",:password => "testing",
      :password_confirmation => "testing",:date_of_birth => '2011-03-02')
    assert user.valid?
  end

  test "user should require valid extension for profile photo" do
    user = User.create(:email => "testx@test.com", :password=>"testing")
    assert_equal user.save, true
    user.avatar = Rails.root.join("test","fixtures","groups.yml").open
    assert !user.valid?
    assert_nil user.avatar_url
    assert_match /is not an allowed file type/, user.errors[:avatar].join
  end

  test "user should update profile photo" do
    ImageUploader.enable_processing = true

    user = User.create(:email => "testx@test.com", :password=>"testing")
    assert_equal user.save, true
    user.avatar = Rails.root.join("test","fixtures","flower.jpg").open
    assert user.valid?        
    assert_avatar_exists(user)

    user.remove_avatar!
    ImageUploader.enable_processing = false
  end

  #Model associations testing
  test "user has many authentications" do
    user = User.create(:email => "test@test.com", :password=>"testing")
    auth = user.authentications.build
    auth.save
    assert_kind_of(Array, user.authentications)
    assert_equal(Authentication.last, auth)
  end

  test "user has many groups" do
    user = User.create(:email => "anothertestemail@test.com", :password=>"testing")
    group = user.groups.build :name => "test group", :description => "this is a test group"
    assert_equal true, group.save
    assert_kind_of(Array, user.groups)
    assert_equal(Group.last, group)
  end


  test "nil user return default pic path" do
    
    assert_equal User::DEFAULT_PIC_URL, User.get_user_pic(nil)
  end

  test "user with no avatar return default pic path" do
    
    user = users(:one)
    
    assert_nil user.avatar_url
    
    assert_equal User::DEFAULT_PIC_URL, User.get_user_pic(user)
  end

  test "user with  avatar return avatar pic path" do
    
    user = User.create(:email => "testx@test.com", :password=>"testing")
    assert_equal user.save, true
    user.avatar = Rails.root.join("test","fixtures","flower.jpg").open
    assert user.valid?    
    assert_not_nil user.avatar_url
    
    assert_equal user.avatar_url, User.get_user_pic(user)
  end

  test "prove image from url is copied to server" do
    ImageUploader.enable_processing = true
    
    avatar_url = "http://w3mg.com/files/2010/02/w3mg_logo.png"
    user = User.create(:email => "mytestx123@test.com", :password=>"testing")
    assert_equal user.save, true
    user.get_avatar_from_url(avatar_url)
    user.reload
    assert_avatar_exists(user)

    user.remove_avatar!
    ImageUploader.enable_processing = false
  end

  test "when created is additional info record created" do
    
    user = User.create(:email => "testx@test.com", :password=>"testing")
    assert_equal user.save, true
    
    user.reload
    
    assert_not_nil user.user_additional_info
  end

end

# == Schema Information
#
# Table name: users
#
#  id                   :integer(4)      not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer(4)      default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  confirmation_token   :string(255)
#  confirmed_at         :datetime
#  confirmation_sent_at :datetime
#  created_at           :datetime
#  updated_at           :datetime
#  gender               :string(255)     default("")
#  birthday             :datetime
#

