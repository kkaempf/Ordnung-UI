source 'http://rubygems.org'

DM_VERSION    = '~> 1.1.0'
  
gem 'rails', '~> 4.1.0'

gem 'bson_ext'
gem 'mongoid', '~> 4.0.0'
gem 'activeresource'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails', :require => false
  gem 'cucumber'
  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page
end
