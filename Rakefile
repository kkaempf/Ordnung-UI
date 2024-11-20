require 'rubygems'
require 'find'
require 'rspec/core/rake_task'

require_relative 'config/application'

task :clean_logs do
  File.delete "log/test.log" rescue nil
end

task :frontend => :clean_logs do
  Find.find('test/frontend') do |f|
    next unless f =~ /.*_test\.rb$/
    `ruby -r'./test/frontend/test_helper' #{f}`
  end
end

task :default => [:clean_logs, :frontend]

namespace :db do
  task :setup do
    Ordnung::Application.start(:db)
    config = OrdnungUI::Application['db.config']
    config.gateways[:default].use_logger(Logger.new($stdout))
  end
end
