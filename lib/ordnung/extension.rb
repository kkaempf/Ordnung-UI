#
# Extension
#
# representing a file extension (without dot)
#

require 'ordnung/rom'

module Ordnung
  class Extension

    def initialize name
      @@repo ||= Repositories::Extensions.new(::Ordnung.rom.container)
      Logger.info "Extension.new(#{name.inspect})"
      raise "Expecting string name" unless name.is_a? String
      while name[0,1] == '.' do
        name = name[1..-1]
      end
      raise "Extension has no characters" if name.empty?
      name = name.downcase
      @struct = @@repo.by_name(name)
      unless @struct
        @struct = @@repo.create(name: name)
      end
    end
    def id
      @struct.id
    end
    def name
      @struct.name
    end
  end
end
