class User < ActiveRecord::Base

  #########################################################
  ######RELATIONSHIPS###################  
  #########################################################
  has_many :authentications
  has_many :groups
  has_many :notification_subscriptions
  
  
  belongs_to :current_broadcast_group, :class_name => "Group", :foreign_key => :current_group_id
  has_one :user_additional_info
  accepts_nested_attributes_for :user_additional_info  # SL is this required to use builder. remove if not
  
  has_many :following_relationships, :class_name=>"Follow", :as=>:following
  has_many :follower_relationships, :class_name=>"Follow", :as=>:followed

  has_many :following_user_relationships, :class_name=>"Follow", :as=>:following, :conditions => "following_type='User'"
  has_many :follower_user_relationships, :class_name=>"Follow", :as=>:followed, :conditions => "followed_type='User'"

  has_many :followed_by, :through => :follower_relationships,:source => :following, :source_type =>'User'
  has_many :is_following, 
           :through => :following_relationships,
           :select => "users.id,avatar,first_name,last_name",
           :source => :followed, 
           :source_type =>'User'

  has_many :group_followers, :through => :follower_relationships,:source => :following, :source_type =>'Group'
  has_many :groups_followed, :through => :following_relationships,:source => :followed, :source_type =>'Group'

  has_one :contact_phone
  accepts_nested_attributes_for :contact_phone
  
  has_one :instant_messenger_account
  accepts_nested_attributes_for :instant_messenger_account

  ## for vanity tag association
  has_one :vanity  , :as=> :owner ,:dependent => :destroy
  accepts_nested_attributes_for :vanity, :allow_destroy => true

  has_many :groups
  
  
  #########################################################
  #DEVISE - 
  #########################################################
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :confirmable,:omniauthable, :recoverable, :registerable, :rememberable, 
    :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :current_password, :password, :password_confirmation, :remember_me,
    :date_of_birth, :gender, :first_name, :last_name,
    :avatar, :remove_avatar, :remote_avatar_url, :vanity_attributes,
    :secret_question_code,:secret_question_answer,:language_code,:time_zone,
    :home_town, :current_town, :interested_in_code, :bio,
    :religion, :religion_description, :political_view, :political_view_description, :favorite_quotes,
    :contact_phone_attributes, :instant_messenger_account_attributes,
    :street_address, :city, :state, :zip_code, :relationship_status_code, :user_additional_info_attributes

  #########################################################
  #CALL BACKS - 
  #########################################################

  after_save :create_user_group, :if => Proc.new { |user| user.groups.blank? }
  after_create :create_additional_info
  after_create :create_contact_and_im
  
  mount_uploader :avatar, AvatarUploader

  
  #########################################################
  ######CONSTANTS###################
  #########################################################
  DEFAULT_PIC_URL = "/images/sticky2_assets/signup/profilepic.png" 
  DEFAULT_THUMB_URL = "/images/sticky2_assets/shared/userthumb.png" 



  #########################################################
  #CLASS METHODS
  #########################################################
 
  ####SESSION AND OATH RELATED
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
      end
    end
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else # Create an user with a stub password. 
      User.create!(:email => data["email"], :password => Devise.friendly_token[0,20]) 
    end
  end

  def update_with_password(params={})
    if params[:current_password].blank? && params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:current_password)
      params.delete(:password)
      params.delete(:password_confirmation)
      update_attributes(params)
    else
      super(params)
    end
 end

  ####PHOTO RELATED  
  def self.get_user_pic(user, image_size="")
 
    return DEFAULT_PIC_URL if user.nil? or user.avatar.url.nil?

     if image_size=="100_100"
       return user.avatar.pic100_100.url

     elsif image_size=="60_60"
       return user.avatar.pic60_60.url

     elsif image_size=="30_30"
       return user.avatar.pic30_30.url

     else  
         return user.avatar.url      
     end  


  end
  
  def get_avatar_from_url(url)
    self.remote_avatar_url = url
    self.save
  end


  def is_super_admin?
    return false
  end


  #########################################################
  #INSTANCE METHODS
  #########################################################


  def apply_omniauth(omniauth, *args)
    
    self.email = omniauth['user_info']['email'] if email.blank?
    
    unless(omniauth['user_info']['name'].blank?)
      names = omniauth['user_info']['name'].split(" ")
      self.first_name = names[0].capitalize if first_name.blank?
      self.last_name = names[1].capitalize if last_name.blank? if(names.size>1)
    else
      self.first_name = omniauth['user_info']['first_name'].capitalize if first_name.blank?
      self.last_name = omniauth['user_info']['last_name'].capitalize if last_name.blank?
    end
    
    #attach photo if available
    unless omniauth['user_info']['image'].nil?
      self.get_avatar_from_url(omniauth['user_info']['image'])
    end
    
    
    #    self.password = self.first_name + '123' if password.blank?
    self.gender = extract_gender_from_omniauth(omniauth)  if gender.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
    args.each {|key|
      self.confirmed_at = Time.now if(key[:verified])
    }
  end


  def get_user_profile_path()
    return self.vanity.blank? ? "/users/#{self.id}" : "/#{self.vanity.tag}"
  end

  #this is from Devise confirmable.rb model.
  # Callback to overwrite if confirmation is required or not.
  def confirmation_required?
    #the original code below but we are making it optional
    #!confirmed?
    false
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end


  def full_name
    return "#{self.first_name} #{self.last_name}"
  end  

  def default_group_path
    return "" if self.groups.nil? or self.groups.size==0
    return self.groups.first.get_group_profile_path
  end

  #####shortcuts for additional info
  
  def athletes
    self.user_additional_info.athletes
  end

  def books
    self.user_additional_info.books
  end


  def games
    self.user_additional_info.games
  end


  def movies    
    self.user_additional_info.movies
  end
  
  
  def music    
    self.user_additional_info.music
  end

  def other
    self.user_additional_info.other
  end
  
  def other_activities  
    self.user_additional_info.other_activities
  end


  def sports
    self.user_additional_info.sports
  end

  def teams
      self.user_additional_info.teams
  end
  
  def television    
    self.user_additional_info.television
  end

  def copy_avatar_to_group
    return if self.avatar_url.blank?
    group = self.groups.where(:personal => true).first
    group.group_image = File.open(self.avatar.current_path)
    group.save
  end

  def social_authorizations
      providers=self.authentications.map{|record| record.provider}
      return providers.uniq
      
  end    
  
  def has_authorized_twitter?
    return self.social_authorizations.include?("twitter")
  end  

  def has_authorized_facebook?
    return self.social_authorizations.include?("facebook")
  end  


########################################################
# BEGIN PRIVATE METHODS
########################################################
  private
  
  def extract_gender_from_omniauth(omniauth)
    return  nil  if omniauth['user_info'].nil?
    
    return  omniauth['user_info']['gender']  unless omniauth['user_info']['gender'].nil?
    
    return omniauth['extra']['user_hash']['gender'] unless omniauth['extra'].nil? or
      omniauth['extra']['user_hash'].nil?
    return nil
  end
  
  def create_user_group
    if(self.first_name.present? && self.last_name.present?)
      self.groups.create!(:name => self.first_name+" "+self.last_name+"'s Group", :description => self.first_name+" "+self.last_name+"'s personal video chat group", :personal => true)
    else
      self.groups.create!(:name => "User's Group", :description => "User's personal video chat group", :personal => true)
    end
  end
  
  
  def create_additional_info
    self.build_user_additional_info
  end

  def create_contact_and_im
    self.build_contact_phone
    self.build_instant_messenger_account
  end

  
  
end
