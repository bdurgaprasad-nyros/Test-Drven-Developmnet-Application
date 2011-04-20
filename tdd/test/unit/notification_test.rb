require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  
  test "notification should save with valid data" do
    notification = Notification.new :body => "this is a new description"
    assert notification.new_record?
    assert notification.valid?
    assert notification.errors.blank?
    assert_equal notification.save, true
  end

  test "notification should belong to one notification type" do
    notification_type = NotificationType.create :name => "New Notification", :description => "This is a new notification"
    assert_equal notification_type.save, true
    notification = notification_type.notifications.build :body => "This is a valid notification"
    assert notification.new_record?
    assert notification.valid?
    assert notification.errors.blank?
    assert_equal notification.save, true
    assert_equal notification.notification_type_id, notification_type.id
  end

  test "notification should belong to one group" do
    user = User.create(:email => "testx@test.com", :password=>"testing")
    group = user.groups.new(:name => "Group", :description => "Valid Description")
    assert_equal group.save, true
    notifications = group.notifications.build
    assert notifications.new_record?
    assert notifications.valid?
    assert notifications.errors.blank?
    assert_equal notifications.save, true
    assert_equal notifications.group_id, group.id
  end

end
