require 'rubygems'
require 'rack/rake_task'
require 'rspec/core/rake_task'

Rack::Test::RakeTask.new(:test) do |task|
  task.rack_opts = ["-c", "-f progress", "-r ./test/test_helper.rb"]
  task.pattern    = 'test/*_test.rb'
end

RSpec::Core::RakeTask.new(:rspec) do |task|
  task.rspec_opts = ["-c", "-f progress", "-r ./rspec/test_helper.rb"]
  task.pattern    = 'rspec/*_test.rb'
end

task :default => :test
