WebChallenge::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Set expire header of 30 days for static files
  config.static_cache_control = "max-age=2592000,public"

  # Enable Rails Assets
  config.assets.enabled = true

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  #Add Fonts Folder to asset path
  config.assets.paths << "#{Rails.root}/app/assets/fonts"

  # Defaults to nil and saved in location specified by config.assets.prefix
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  config.assets.precompile += %w[ active_admin.css active_admin.js active_admin/print.css application.css application.js challenge-cn.js challenge-en.js challenge-tw.js *.png *.jpg *.jpeg *.gif *.svg *.eot *.woff *.ttf ]

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :enable_starttls_auto => false,
    :address => "mail.studio912.sg",
    :port => 587,
    :domain => "rhcloud.com",
    :authentication => :plain,
    :user_name => "registration@studio912.sg",
    :password => "redhat123"
  }

  #The Line below defines Gmail SMTP Server
  #ActionMailer::Base.smtp_settings = {
  #  :enable_starttls_auto => true,
  #  :address => "smtp.gmail.com",
  #  :port => 587,
  #  :domain => "rhcloud.com",
  #  :authentication => :plain,
  #  :user_name => "exmaple@gmail.com",
  #  :password => "password"
  #}
  #config.action_mailer.delivery_method = :smtp

  config.action_mailer.default_url_options = {
    :host => "redhatchallenge-rhc.rhcloud.com",
    :protocol => 'https'
  }

end
