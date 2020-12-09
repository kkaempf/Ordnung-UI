require 'rom-core'
require 'rom-sql'

module Ordnung
  ROM_TYPE = :sql
end

require_relative 'rom/relations'

require_relative 'rom/repositories'

module Ordnung

  class ROM
    attr_reader :container
    def initialize
      Logger.info "ROM.initialize"
      @config = ::ROM::Configuration.new(ROM_TYPE, 'sqlite://ordnung.db')
      @config.register_relation Relations::Files
      @config.register_relation Relations::Extensions
      @config.register_relation Relations::Directories
      @container = ::ROM.container(@config)
    end
    def files_repo
      @files_repo ||= Repositories::Files.new(@container)
    end
  end
end

