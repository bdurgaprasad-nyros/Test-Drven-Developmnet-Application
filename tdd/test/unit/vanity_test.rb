require File.expand_path('../../test_helper.rb', __FILE__)


class VanityTest < ActiveSupport::TestCase
  
  test "can create a vanity for a user" do
    vanity_count_before=Vanity.all.size
    
    user = User.create(:email => "email@test.com", :password => "testing")
    vanity=Vanity.create(:tag=>"silly", :owner_type=>User, :owner_id=>user.id)
    assert_not_nil vanity
    
    assert_equal vanity_count_before+1, Vanity.all.size    
  end
  
  test "can create a vanity for a group" do
    vanity_count_before=Vanity.all.size
    group = Group.new(:name => "Valid name", :description => "valid description")
    
    vanity=Vanity.create(:tag=>"sillier", :owner_type=>Group, :owner_id=>group.id)
    assert_not_nil vanity
    
    assert_equal vanity_count_before+1, Vanity.all.size    
  end
  

  test "cannot create vanity with tag that exists" do
     vanity_count_before=Vanity.all.size
    
     group = Group.new(:name => "Valid name", :description => "valid description")
     user = User.create(:email => "email@test.com", :password => "testing")
     
      vanity=Vanity.create(:tag=>"silly", :owner_type=>User, :owner_id=>user.id)
      vanity2=Vanity.create(:tag=>"silly", :owner_type=>Group, :owner_id=>group.id)

     assert_equal vanity_count_before+1, Vanity.all.size 

  end

end
