#In Development Mode uncomment source :rubygems and comment source 'http://mirror1.prod.rhcloud.com/mirror/ruby/'
#In Production Mode uncomment source 'http://mirror1.prod.rhcloud.com/mirror/ruby/' and comment source :rubygems
source 'http://mirror1.prod.rhcloud.com/mirror/ruby/'
#source :rubygems

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'
gem 'devise'
gem 'activeadmin'
gem 'recaptcha', :require => 'recaptcha/rails'
gem 'css3-progress-bar-rails'
gem 'host'

# Gems used only for development and not required
# in production environment by default.
#The entire section can be commented out safely to reduce the Gems required
group :development do
  gem 'sqlite3'
  # This needs to be installed so we can run Rails console on OpenShift directly
  gem 'minitest'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

# This version needs to be hardcoded for OpenShift compatability
gem 'thor', '= 0.14.6'
