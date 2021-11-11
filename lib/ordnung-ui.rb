require 'yaml'
require 'ordnung'

unless defined?(ORDNUNG_UI_TOPLEVEL)
  ORDNUNG_UI_TOPLEVEL = File.expand_path("..", File.dirname(__FILE__))
end

require_relative "ordnung-ui/config"

module OrdnungUI
  VERSION = '0.2.0'

  extend self

  def logger
    @@logger ||= Logger.new
  end

  def mimetype
    @@mimetype ||= MimeType.new
  end
  
  def get_colors
    conf = ::File.join(TOPLEVEL,"config","colors.yml")
    YAML.load_file(conf)
  end

  class OrdnungUI
    def logger
      ::Ordnung.logger
    end
  end

end
