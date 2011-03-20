# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
TrenchesRb::Application.initialize!

# Change default sass path
Sass::Plugin.options[:template_location] = "./public/stylesheets"

# Don't regenerate css files in production
Sass::Plugin.options[:never_update] = true if Rails.env.production?

# Show debug_info for FireSass
Sass::Plugin.options[:debug_info] = true
