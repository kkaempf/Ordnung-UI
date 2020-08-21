DEBUG = false unless defined?(DEBUG)
ENV['RACK_ENV'] = 'test'
TOPLEVEL = File.dirname(__FILE__)
$:.push(File.expand_path(File.join(TOPLEVEL, "..", "..", 'lib')))

require 'ordnung'
require 'rspec'
require 'rack/test'
