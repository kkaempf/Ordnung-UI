unless defined?(ORDNUNG_UI_TOPLEVEL)
  ORDNUNG_UI_TOPLEVEL = File.expand_path("..", File.dirname(__FILE__))
end

require_relative "ordnung-ui/config"

module OrdnungUI
  VERSION = '0.2.0'

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
    def initialize
      require 'arango-driver'
      attrs = {
        username: Config[:db_user], password: Config[:db_password], host: Config[:db_host], port: Config[:db_port]
      }
      logger.info "attrs #{attrs.inspect}"
      server = Arango.connect_to_server  username: Config[:db_user], password: Config[:db_password], host: Config[:db_host], port: Config[:db_port]

      require 'ordnung'
      name = Config[:db_database]
      database = if server.database_exists?(name: name)
        server.get_database(name: name)
      else
        server.create_database(name: name)
      end
      Ordnung.database = database
      Ordnung.setup
    end
  end

end
