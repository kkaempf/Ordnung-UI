ENV['RACK_ENV'] = 'test'

top = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "lib"))
STDERR.puts "top #{top}"
$:.unshift top

require 'selenium-webdriver'

require 'capybara/rspec'
require 'test/unit'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new( app, :browser => :firefox)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.firefox(
    firefoxOptions: { args: %w(headless) }
  )
      
  Capybara::Selenium::Driver.new( app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end

Capybara.javascript_driver = :headless_firefox
Capybara.server = :webrick

Capybara.configure do |config|
  config.default_max_wait_time = 20 # seconds
  config.default_driver = :selenium
end

