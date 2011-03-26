source 'http://rubygems.org'

DM_VERSION    = '~> 1.1.0'
  
gem 'rails', '3.0.5'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'sqlite3'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# DataMapper
# https://github.com/datamapper/dm-rails
gem 'dm-rails', DM_VERSION
gem 'bson_ext'
gem 'mongo'
gem 'dm-aggregates'
gem 'dm-migrations'
gem 'dm-mongo-adapter'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

group :test do
  gem 'rspec-rails', '>= 2.4.0'
end

group :cucumber do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'cucumber', '0.8.5'
  gem 'rspec-rails', '>= 2.4.0'
  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page
end
