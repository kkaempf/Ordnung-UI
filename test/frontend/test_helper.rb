ENV['RACK_ENV'] = 'test'

top = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "lib"))
STDERR.puts "top #{top}"
$:.unshift top

require 'capybara'
require 'selenium-webdriver'
gem 'chromedriver-helper'

require 'capybara/dsl'
require 'test/unit'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new( app, :browser => :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w(headless disable-gpu) }
  )
      
  Capybara::Selenium::Driver.new( app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end

Capybara.javascript_driver = :headless_chrome
Capybara.server = :webrick
#Capybara.javascript_driver = :chrome

Capybara.configure do |config|
  config.default_max_wait_time = 20 # seconds
  config.default_driver = :selenium
end

#Capybara.app_host = 'http://127.0.0.1:4567/'
