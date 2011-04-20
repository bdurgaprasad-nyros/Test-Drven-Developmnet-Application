Vchatter::Application.routes.draw do

  resources :deletion_feedbacks

  get "home/index"


  ### Two routes defined for accout settings and update actions 
  get "profile/account_settings"
  match 'profile/account_update' => 'profile#account_update', :via => :put

  get "profile/basic_information"
  put "profile/basic_information"
  
  get "profile/activities"
  match 'profile/activities_update' => 'profile#activities_update', :via => :put
  
  
  match "profile/password_update", :via=>:post
  
  get "profile/relationships"
  match 'profile/relationships_update' => 'profile#relationships_update', :via => :put

  get "profile/image"
  match 'profile/image_update' => 'profile#image_update', :via => :post

  get "profile/interests"
  match 'profile/interests_update' => 'profile#interests_update', :via => :put

  get "profile/philosophy"
  match 'profile/philosophy_update' => 'profile#philosophy_update', :via => :put

  get "profile/contact_information"
  #get "profile/contact_information/:id" => "profile#contact_information"
  match 'profile/contact_information_update' => 'profile#contact_information_update', :via => :put

  match 'profile/deactiviate_account' => 'profile#deactiviate_account', :via => :post

  get "vanities/check_availability"


  
  resources :notification_preferences
  resources :notification_types
  resources :notification_subscriptions
  resources :notifications

  # welcome controller= standard web stuff content
  get "welcome/index"  # the 'home page

  get "welcome/about_us"
  get "welcome/jobs"
  get "welcome/fans"
  get "welcome/twitter"
  get "welcome/facebook"
  get "welcome/press"
  get "welcome/terms"
  get "welcome/privacy"
  get "welcome/help"
  get "welcome/quickstart_guide"
  get "welcome/tips"
  get "welcome/community_guidelines"
  get "welcome/contact_us"

  resources :groups do
    member do
      post :update_count
    end
    collection do
      get :most_popular
      get :most_recent
      get :recommended
    end
  end

  resource :welcome

  devise_for :users, :controllers => {:registrations => 'registrations', 
                                      :sessions=>'sessions',
                                      :omniauth_callbacks => "users/omniauth_callbacks"} do
      post "registrations/step_2" => "registrations#step_2"
      post "registrations/step_3" => "registrations#step_3"
       
  end

  resources :follows

  resources :users do
      resources :follows
      resources :followers
      member do
        get :locate
      end
      
  end
  
  
  
  # resources :users do
  #     resources :groups
  # end
   
  resources :authentications
  resource :photo
  
  get "photo/new_photo_form"
  get "photo/new_photo_iframe"
  post "photo/set_image"

  root :controller => :welcome, :action => 'index'
  
  #this route should be last as it checks for the vanity urls
  get '/:vanity_name', :controller => 'vanities', :action => 'show'
  
  
end
