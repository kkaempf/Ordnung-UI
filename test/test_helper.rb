ENV['RACK_ENV'] = 'test'

#require_relative '../bin/app'
require 'capybara'
require 'capybara/dsl'
require 'test/unit'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
Capybara.default_driver = :selenium
