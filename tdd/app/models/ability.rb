class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    can :read, :all
    can :create, Group
    can :update_count, Group
    can :recommended, Group
    can :most_recent, Group
    can :most_popular, Group
    can :update, Group do |group|
      group.try(:user) == user
    end
    can :destroy, Group do |group|
      group.try(:user) == user
    end
    
    can :create, Follow
    can :destroy, Follow 
    
    
  end
  
end