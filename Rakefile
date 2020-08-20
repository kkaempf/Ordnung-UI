require 'rubygems'
require 'find'
require 'rspec/core/rake_task'

task :clean_logs do
  File.delete "log/test.log" rescue nil
end

task :frontend => :clean_logs do
  Find.find('test/frontend') do |f|
    next unless f =~ /.*_test\.rb/
    `ruby -r'./test/frontend/test_helper' #{f}`
  end
end

RSpec::Core::RakeTask.new(:backend) do |task|
  task.rspec_opts = ["-c", "-f progress", "-r ./test/backend/test_helper.rb"]
  task.pattern    = 'test/backend/*_test.rb'
end

task :default => [:clean_logs, :backend]
