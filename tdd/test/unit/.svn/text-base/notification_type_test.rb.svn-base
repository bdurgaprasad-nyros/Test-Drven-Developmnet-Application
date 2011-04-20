require 'test_helper'

class NotificationTypeTest < ActiveSupport::TestCase

  test "notification type should save with name only" do
    notification_type = NotificationType.new :name => "New Notification"
    assert notification_type.new_record?
    assert notification_type.valid?
    assert notification_type.errors.blank?
    assert_equal notification_type.save, true
  end

  test "notification type should save with description only" do
    notification_type = NotificationType.new :description => "This is a new notification"
    assert notification_type.new_record?
    assert notification_type.valid?
    assert notification_type.errors.blank?
    assert_equal notification_type.save, true
  end

  test "notification type should save with name and description" do
    notification_type = NotificationType.new :name => "New Notification", :description => "This is a new notification"
    assert notification_type.new_record?
    assert notification_type.valid?
    assert notification_type.errors.blank?
    assert_equal notification_type.save, true
  end

  test "notification type should have many notification subscriptions" do
    notification_type = NotificationType.create :name => "New Notification", :description => "This is a new notification"
    notification_subscription = notification_type.notification_subscriptions.build
    assert_equal notification_subscription.save, true
    assert_kind_of Array, notification_type.notification_subscriptions
    assert_equal NotificationSubscription.last, notification_subscription
  end

  test "notification type should have many notifications" do
    notification_type = NotificationType.create :name => "New Notification", :description => "This is a new notification"
    notifications = notification_type.notifications.build
    assert_equal notifications.save, true
    assert_kind_of Array, notification_type.notifications
    assert_equal Notification.last, notifications
  end

end
