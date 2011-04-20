require File.expand_path('../../test_helper.rb', __FILE__)

class GroupTest < ActiveSupport::TestCase

  setup do
    ImageUploader.enable_processing = true
  end

  teardown do
    ImageUploader.enable_processing = false
  end

  test "group should not save upon blank submission" do
    group = Group.new()
    assert_equal group.save, false
  end

  test "group should validate presence of name" do
    group = Group.new(:name => '', :description => "valid description")
    assert group.new_record?
    assert !group.valid?
    assert group.errors[:name]
    assert_match /can\'t be blank*/, group.errors[:name].join
  end

  test "group should require a name with minimum of 2 characters" do
    group = Group.new(:name => "G", :description => "valid description")
    assert group.new_record?
    assert !group.valid?
    assert group.errors[:name]
    assert_match /is too short \(minimum is 2 characters/, group.errors[:name].join
  end

  test "group should require a name with maximum of 50 characters" do
    group = Group.new(:name => "This is the group with name of more then fifty 50 characters", :description => "valid description")
    assert group.new_record?
    assert !group.valid?
    assert group.errors[:name]
    assert_match /is too long \(maximum is 50 characters/, group.errors[:name].join
  end

  test "group should require valid extension for group_image" do
    group = Group.new(:name => "Valid name", :description => "valid description", :group_image => Rails.root.join("test","fixtures","groups.yml").open)
    assert !group.valid?
    assert_nil group.group_image.url
    assert_match /is not an allowed file type/, group.errors[:group_image].join
  end

  test "group should save with valid name, description and group image" do
    group = Group.new(:name => "Valid Name", :description => "Valid Description", :group_image => Rails.root.join("test","fixtures","flower.jpg").open)
    group.user = users(:one)
    assert group.new_record?
    assert group.valid?
    assert group.errors.blank?
    assert_equal group.save, true
    assert_group_image_exists(group)
    group.remove_group_image!
  end

  test "group should belong to only one user" do
    user = User.create(:email => "testx@test.com", :password=>"testing")
    assert_equal user.save, true
    group = user.groups.build :name => "test group", :description => "this is a test group"
    assert group.new_record?
    assert group.valid?
    assert group.errors.blank?
    assert_equal group.save, true
    assert_equal group.user_id, user.id
  end

  test "group be followed by user" do
    user = users(:one)
    group = user.groups.build :name => "test group", :description => "this is a test group"
    group.save!
    
    user.reload
    assert user.groups_followed.include?(group)
  end
  
  
  test "grab trending groups" do   
    trending_groups = Group.get_trending_groups
    
    assert_equal groups(:three), trending_groups.first
    assert_equal groups(:one), trending_groups.second
    assert_equal groups(:two), trending_groups.third
    assert_equal 3, trending_groups.count
    
  end

  test "grab recommended groups" do
    recommended_groups = Group.get_recommended_groups
    assert_equal groups(:three), recommended_groups.first
    assert_equal groups(:two), recommended_groups.second
    assert_equal 2, recommended_groups.count
    assert_equal Group.find_by_sql("select * from groups where recommended=1 order by current_user_count desc limit 10").size, recommended_groups.size

  end

  test "grab more recommended groups " do
    recommended_groups = Group.get_more_recommended_groups

    assert_equal groups(:three), recommended_groups.first
    assert_equal groups(:two), recommended_groups.second
    assert_equal 2, recommended_groups.count
  end

  test "grab recent groups " do
    recent_groups = Group.get_most_recent_groups

    assert_equal groups(:two), recent_groups.first
    assert_equal groups(:three), recent_groups.second
    assert_equal groups(:one), recent_groups.third
    assert_equal 3, recent_groups.count
  end

end

# == Schema Information
#
# Table name: groups
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

