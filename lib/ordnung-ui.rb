unless defined?(ORDNUNG_UI_TOPLEVEL)
  ORDNUNG_UI_TOPLEVEL = File.expand_path("..", File.dirname(__FILE__))
end

require_relative "ordnung-ui/config"

gem 'ordnung'
require 'ordnung'

module OrdnungUI
  VERSION = '0.2.1'

  extend self

  def mimetype
    @@mimetype ||= MimeType.new
  end
  
  def get_colors
    conf = ::File.join(ORDNUNG_UI_TOPLEVEL,"config","colors.yml")
    YAML.load_file(conf)
  end

  class UI
    def logger
      ::Ordnung.logger
    end
  end

end
