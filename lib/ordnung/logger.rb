#
# Ordnung::Logger
#
require 'logger'

module Ordnung

  class Logger < ::Logger
    attr_reader :logname, :logfile
    def self.error msg
      ::Ordnung.logger.error msg
    end
    def self.warn msg
      ::Ordnung.logger.warn msg
    end
    def self.info msg
      ::Ordnung.logger.info msg
    end
    def self.debug msg
      ::Ordnung.logger.debug msg
    end
    def initialize
      @logname = Config["logfile"]
      @logfile = nil
      case @logname
      when "stderr", "STDERR"
        @logfile = STDERR
      when "stdout", "STDOUT"
        @logfile = STDOUT
      when "", nil
        logdir = File.join(TOPLEVEL,"log")
        Dir.mkdir(logdir) rescue nil
        @logname = File.join(logdir, "ordnung.log")
      else
        # assume valid file path
      end
      if @logfile.nil?
        begin
          @logfile = File.new(@logname, "a+")
        rescue Exception => e
          STDERR.puts "Log file creation '#{@logname}' failed: #{e}"
        end
      end
      super @logfile
      self.level = case Config["debug"]
        when "debug" then Logger::DEBUG
        when "info" then Logger::INFO
        when "warn" then Logger::WARN
        when "error" then Logger::ERROR
        else
          Logger::FATAL
        end
    end
  end

end
