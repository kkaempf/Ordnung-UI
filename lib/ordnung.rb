require 'yaml'

TOPLEVEL = File.expand_path("..", File.dirname(__FILE__))

require_relative "ordnung/config"
require_relative "ordnung/database"
require_relative "ordnung/entry"
require_relative "ordnung/import"
require_relative "ordnung/mime_type"
require_relative "ordnung/logger"
require_relative "ordnung/version"

module Ordnung

  extend self

  def logger
    @@logger ||= Logger.new
  end

  def database
    @@database ||= Database.new
  end

  def mimetype
    @@mimetype ||= MimeType.new
  end

  def get_colors
    conf = File.join(TOPLEVEL,"config","colors.yml")
    YAML.load_file(conf)
  end

  class Ordnung
  end

end
