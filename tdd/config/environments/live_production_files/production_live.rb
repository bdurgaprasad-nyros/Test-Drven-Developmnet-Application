Vchatter::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Specifies the header that your server uses for sending files
  config.action_dispatch.x_sendfile_header = "X-Sendfile"

  # For nginx:
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'

  # If you have no front-end server that supports something like X-Sendfile,
  # just comment this out and Rails will serve the files

  # See everything in the log (default is :info)
  #config.log_level = :warn

  # Use a different logger for distributed setups
  #config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_assets = false

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true


  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify
  config.action_mailer.delivery_method = :ses
  config.action_mailer.default_url_options = { :host => 'betatest.vchatter.com' }
  
  #don't know what this is for
  FACEBOOK_APP_ID="142866185778773"
  FACEBOOK_API_KEY="99a6de550a18c777a4b4fdd680c073c2"
  FACEBOOK_APP_SECRET="a6a266aa6c390fac688c8e015ab1e286"

  #for vchatter test application
  FACEBOOK_APP_ID="127129540633419"
  FACEBOOK_API_KEY="54bf449bc9489ea199874ccd2da85309"
  FACEBOOK_APP_SECRET="069ce7cf1ae5c29c3971fe5729c040cf"
  
  WEBAPP_URL="betatest.vchatter.com"
  
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
