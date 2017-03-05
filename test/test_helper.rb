DEBUG = false unless defined?(DEBUG)
ENV['RACK_ENV'] = 'test'
TOPLEVEL = File.dirname(__FILE__)
$LOAD_PATH.unshift File.expand_path(File.join(TOPLEVEL, ".."))
load 'bin/app'
require 'rspec'
require 'rack/test'
