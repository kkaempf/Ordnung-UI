#
# OrdnungUI::Config
#

module OrdnungUI

  #
  # Config
  #
  class Config
    @@yaml = nil
    # load config.yml once
    def self.content
      @@conf ||= ::File.join(ORDNUNG_UI_TOPLEVEL,"config","config.yml")
      begin
	@@yaml ||= YAML.load_file(@@conf)
      rescue Exception => e
	# 'log' to stderr since logger might not be initialized yet
	STDERR.puts "Can't load '#{@@conf}': #{e}"
      end
      @@yaml
    end
    # access config section by name
    def self.[] name
      self.content[name.to_s]
    end
    def self.method_missing(name, *args, &block)
#      puts "Config.#{name}: #{self.content[name.to_s]}"
      self.content[name.to_s] || abort("No #{name} defined in config.yml")      
    end
  end

end
