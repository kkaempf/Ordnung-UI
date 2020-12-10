DEBUG = false unless defined?(DEBUG)
ENV['RACK_ENV'] = 'test'
ENV['APP_ENV'] ||= 'test'
TOPLEVEL = File.expand_path(File.join(File.dirname(__FILE__), "..", ".."))
$:.push(File.join(TOPLEVEL, 'lib'))

require_relative File.join(TOPLEVEL, 'config', 'application')
require 'ordnung'
require 'rspec'
require 'rack/test'
