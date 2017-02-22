require 'yaml'

TOPLEVEL = File.expand_path("..", File.dirname(__FILE__))

require_relative "ordnung/config"
require_relative "ordnung/database"
require_relative "ordnung/ordnung"
require_relative "ordnung/logger"
require_relative "ordnung/version"

module Ordnung

  extend self

  def logger
    @@logger ||= Logger.new
  end

  def get_colors
    conf = File.join(TOPLEVEL,"config","colors.yml")
    YAML.load_file(conf)
  end

end
