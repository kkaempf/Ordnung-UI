#
# Extension
#
# representing a file extension (without dot)
#

require 'ordnung/rom'

module Ordnung
  class Extension

    def initialize name_or_id
      @@repo ||= Repositories::Extensions.new(::Ordnung.rom.container)
      Logger.info "Extension.new(#{name_or_id.inspect})"
      case name_or_id
      when Integer
        @struct = @@repo.by_id(name_or_id)
        raise "No such extension_id #{name_or_id}" unless @struct
      when String
        name = name_or_id
        while name[0,1] == '.' do
          name = name[1..-1]
        end
        raise "Extension has no characters" if name.empty?
        name = name.downcase
        @struct = @@repo.by_name(name) || @@repo.create(name: name)
      else
        raise "Expecting string name"
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
