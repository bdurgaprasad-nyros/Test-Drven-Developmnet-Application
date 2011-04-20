require File.expand_path('../../test_helper.rb', __FILE__)

class FollowTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "does the follows relationship work" do
     person_following = users(:two)
     person_followed = users(:one)
     
     followed = person_following.following_relationships.first
     assert_not_nil followed
     
     assert_equal person_followed.id, followed.followed_id
  end

  test "does the followed relationship work" do
     person_following = users(:two)
     person_followed = users(:one)
     
     follower = person_followed.follower_relationships.first
     assert_not_nil follower
     
     assert_equal person_following.id, follower.following_id
  end
  
  test "can i get to follower and followed via follow" do
    
    person_following = users(:two)
    person_followed = users(:one)

    relationship = follows(:one)
    
    assert_equal person_following, relationship.following
    assert_equal person_followed, relationship.followed
    
  end
  
  test "can go straight from user to followers" do
  
    person_following = users(:two)
    person_followed = users(:one)

    assert_equal person_following, person_followed.followed_by.first
  
  end
  
  test "can go straight from user to followed" do
  
    person_following = users(:two)
    person_followed = users(:one)

    assert_equal person_followed, person_following.is_following.first
  
  end
  
  
  
end
