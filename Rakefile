require 'rubygems'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:test) do |task|
  task.rspec_opts = ["-c", "-f progress", "-r ./rspec/test_helper.rb"]
  task.pattern    = 'rspec/*_test.rb'
end

task :default => :test
