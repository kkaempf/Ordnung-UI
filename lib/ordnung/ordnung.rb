#
# ordnung/ordnung.rb
#

require_relative "import.rb"

module Ordnung
  class Ordnung
    def initialize database = nil
      @client = Elasticsearch::Client.new log: true
      @client.transport.reload_connections!
    end
    def logger
      @logger ||= Logger.new
    end
  end
end
