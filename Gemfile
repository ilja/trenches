source 'http://rubygems.org'
ruby "1.9.3"

gem 'rails', '~>3.2.8'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'dalli'
gem 'memcachier'

gem 'json'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
#gem 'ruby-debug19', :require => 'ruby-debug'

gem 'sorcery', "~> 0.7.0"

# markdown
gem 'rdiscount'

gem "friendly_id", "~> 4.0.0"

group :development do
  gem 'guard'
#  gem 'guard-livereload'
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
#  gem 'growl_notify'
  gem 'quiet_assets'
  #gem 'thin'
  gem 'guard-rspec'
#  gem 'rack-livereload'
  gem 'puma'
  gem 'sextant'
end

gem 'simplecov', :require => false, :group => :test
gem 'cucumber-rails', :require => false, :group => :test

group :test do
  gem 'sqlite3'
end

group :test, :development do
  gem "rspec-rails", "~> 2.7"
  gem 'factory_girl_rails'
  gem "capybara"
  gem 'launchy'
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem 'pry'
end

group :development, :production do
  gem 'pg'
end
