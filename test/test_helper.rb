ENV['RACK_ENV'] = 'test'

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), ".."))
load 'bin/app'
require 'rspec'
require 'rack/test'
