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
      @container = ::ROM.container(ROM_TYPE, ::Ordnung::Application['db.name']) do |config|
        config.relation(:files) do
          schema(infer: true)
          auto_struct true
        end
        config.relation(:extensions) do
          schema(infer: true)
          auto_struct true
        end
        config.relation(:directories) do
          schema(infer: true)
          auto_struct true
        end
        config.relation(:mimetypes) do
          schema(infer: true)
          auto_struct true
        end
      end
    end
    def files_repo
      @files_repo ||= Repositories::Files.new(@container)
    end
    def extensions_repo
      @extensions_repo ||= Repositories::Extensions.new(@container)
    end
    def directories_repo
      @directories_repo ||= Repositories::Directories.new(@container)
    end
  end
end

