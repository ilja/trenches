source 'http://rubygems.org'

gem 'rails', '~>3.2.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


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

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
#gem 'ruby-debug19', :require => 'ruby-debug'

gem 'sorcery'

gem "friendly_id", "~> 4.0.0"

group :development do
  gem 'guard'
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
#  gem 'growl_notify'

  gem 'guard-rspec'
end

gem 'simplecov', :require => false, :group => :test

group :test, :development do
  gem "rspec-rails", "~> 2.7"
  gem 'factory_girl_rails'
  gem "capybara"
  gem 'cucumber-rails'
  gem 'launchy'
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
end
