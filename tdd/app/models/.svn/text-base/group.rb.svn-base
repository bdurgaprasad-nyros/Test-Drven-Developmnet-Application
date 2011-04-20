class Group < ActiveRecord::Base

  DEFAULT_PIC_URL = "/images/sticky2_assets/groups/defaultpic.png" 
  DEFAULT_THUMB_URL = "/images/sticky2_assets/shared/groupthumb.png" 

  belongs_to :user
  has_many :notifications
  has_many :notification_subscriptions
  has_many :notification_types, :through => :notification_subscriptions

  has_many :following_relationships, :class_name=>"Follow", :as=>:following
  has_many :follower_relationships, :class_name=>"Follow", :as=>:followed
  has_many :recent_follower_relationships, :class_name=>"Follow", :as=>:followed, :order=>"created_at desc"

  has_many :followed_by, :through => :follower_relationships,:source => :following, :source_type =>'User'
  has_many :recent_followers, :through => :follower_relationships,:source => :following, :source_type =>'User', :limit=>5
  has_many :is_following, :through => :recent_follower_relationships,:source => :followed, :source_type =>'User'

  has_many :group_followers, :through => :follower_relationships,:source => :following, :source_type =>'Group'
  has_many :groups_followed, :through => :following_relationships,:source => :followed, :source_type =>'Group'



  validates :name,  :presence => true
  validates :user_id,  :presence => true
  validates_length_of :name, :in => 2..50

  has_one :vanity  , :as=> :owner ,:dependent => :destroy
  has_one :notification_preference, :dependent => :destroy
  accepts_nested_attributes_for :vanity, :allow_destroy => true
  accepts_nested_attributes_for :notification_preference, :allow_destroy => true,
                                :reject_if => proc { |attrs| attrs['frequency_code'].blank? }

  attr_accessible :name, :description,
                  :background_image, :group_image,
                  :remove_group_image, :remove_background_image,
                  :vanity_attributes, :notification_preference_attributes,
                  :notification_type_ids, :personal

  mount_uploader :background_image, ImageUploader
  mount_uploader :group_image, AvatarUploader

  after_create :creater_must_follow

##################################################
# CLASS METHODS
##################################################
  def self.get_group_pic(group, image_size=nil)
    
    return DEFAULT_PIC_URL if group.nil? or group.group_image.url.nil?
    
    
    image_size="" if image_size.nil?
    
    if image_size=="100_100"
      return group.group_image.pic100_100.url
    
    elsif image_size=="60_60"
      return group.group_image.pic60_60.url

    elsif image_size=="30_30"
      return group.group_image.pic30_30.url
      
    else  
        return group.group_image.url       
    end  

  end
  
  
  
  def self.get_trending_groups
    
    Group.find_by_sql("select * from groups where current_user_count > 0 order by current_user_count desc limit 10")
    
  end
  
  def self.get_recommended_groups
    
    Group.find_by_sql("select * from groups where recommended=1 order by current_user_count desc limit 10")
    
  end

  def self.get_more_recommended_groups
    
    Group.find_by_sql("select * from groups where recommended=1 order by current_user_count desc limit 20")
    
  end
  def self.get_most_recent_groups
    #Group.all
    #Group.find(:all, :conditions=>["current_user_count > 0"], :order=>"created_at DESC", :limit=>20)
    Group.find_by_sql("select * from groups where  current_user_count > 0 order by created_at DESC limit 20")
    
  end


  ##################################################
  # INSTANCE METHODS
  ##################################################

  
  def creater_must_follow
    self.user.groups_followed << self
  end

  def get_group_profile_path()
    return self.vanity.blank? ? "/groups/#{self.id}" : "/#{self.vanity.tag}"
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

