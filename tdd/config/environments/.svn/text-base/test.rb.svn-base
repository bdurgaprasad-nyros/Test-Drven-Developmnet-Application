Vchatter::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite.  You never need to work with it otherwise.  Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs.  Don't rely on the data there!
  config.cache_classes = true

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  
  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr
  
  WEBAPP_URL="betatest.vchatter.com"
  
  FACEBOOK_APP_ID="142866185778773"
  FACEBOOK_API_KEY="99a6de550a18c777a4b4fdd680c073c2"
  FACEBOOK_APP_SECRET="a6a266aa6c390fac688c8e015ab1e286"
  TWITTER_API_KEY="xN2qpr5sMpLqeIQvxOOVg"
  TWITTER_CONSUMER_KEY="xN2qpr5sMpLqeIQvxOOVg"
  TWITTER_CONSUMER_SECRET="QlOsCgUW2ZQu8d9oNF2WkIgOYbTB9xTda9nQcs8G4"
  
  AMAZON_SECRET_KEY="+cwEJRYI6BPJsnv/7FBe+PQDv7bYf8FlVxdAno8T"
  AMAZON_ACCESS_KEY="AKIAJ4IA45OOOCJZQZ5A"
  
    # Bunchball start
  # Constants
	BUNCHBALL_CRITERIA_MAX = "MAX";
	BUNCHBALL_CRITERIA_CREDITS = "credits";
	BUNCHBALL_POINT_CATEGORY_ALL = "all";
	BUNCHBALL_TAGS_OPERATOR_OR = "OR";   

   # Required Parameters
   BUNCHBALL_BASE_URL = "http://sandbox.bunchball.net/nitro/api?"
   BUNCHBALL_REQUEST_URL = "http://sandbox.bunchball.net/nitro/json?"
   BUNCHBALL_SECRET_KEY = "8c1b98b8ef714e789c777240d1f464fc"                # Our secretKey to connect to the API
   BUNCHBALL_API_KEY = "4788fa097457436db284af3781f6ceba"                   # Our apiKey to connect to the API
  
end
