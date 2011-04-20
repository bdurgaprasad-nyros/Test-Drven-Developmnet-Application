require 'test_helper'

class NotificationSubscriptionTest < ActiveSupport::TestCase
  
  test "notification subscription should belong to one user" do
    user = User.create(:email => "testx@test.com", :password=>"testing")
    assert_equal user.save, true
    notification_subscriptions = user.notification_subscriptions.build 
    assert notification_subscriptions.new_record?
    assert notification_subscriptions.valid?
    assert notification_subscriptions.errors.blank?
    assert_equal notification_subscriptions.save, true
    assert_equal notification_subscriptions.user_id, user.id
  end

  test "notification subscription should belong to one group" do
    user = User.create(:email => "testx@test.com", :password=>"testing")
    group = user.groups.new(:name => "Group", :description => "Valid Description")
    assert_equal group.save, true
    notification_subscriptions = group.notification_subscriptions.build
    assert notification_subscriptions.new_record?
    assert notification_subscriptions.valid?
    assert notification_subscriptions.errors.blank?
    assert_equal notification_subscriptions.save, true
    assert_equal notification_subscriptions.group_id, group.id
  end

  test "notification subscription should belong to one notification type" do
    notification_type = NotificationType.new :name => "New Notification", :description => "This is a new notification"
    assert_equal notification_type.save, true
    notification_subscriptions = notification_type.notification_subscriptions.build 
    assert notification_subscriptions.new_record?
    assert notification_subscriptions.valid?
    assert notification_subscriptions.errors.blank?
    assert_equal notification_subscriptions.save, true
    assert_equal notification_subscriptions.notification_type_id, notification_type.id
  end

end
