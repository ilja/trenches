source 'http://rubygems.org'

gem 'rails', '~>3.1.0.rc1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

# Asset template engines
gem 'sass'
gem 'coffee-script'
gem 'uglifier'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'


gem 'jquery-rails'
gem 'pjax_rails'

gem 'launchy'

# authentication with omniauth
gem 'omniauth'

# authorization with cancan
gem 'cancan', '~>1.6.1'

# markdown
gem 'rdiscount'

# fix sass @import stuff?
gem 'tilt', :git => 'git://github.com/rtomayko/tilt.git'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

gem 'mongoid', '>= 2.0.1'
gem 'bson_ext', '>= 1.3.0'

group :development, :test do
  gem 'rspec-rails', '>= 2.0.1'
  gem 'watchr'
  gem 'notifier'
  gem 'spork', '~>0.9.0rc'
  gem 'factory_girl_rails'
  # Pretty printed test output
  gem 'turn', :require => false
end

gem 'cucumber-rails', :group => :test
gem 'capybara', :group => :test
gem 'database_cleaner', :group => :test
#gem 'haml', '>= 3.0.0'
#gem 'sass' # automatically compile sass and scss to css
