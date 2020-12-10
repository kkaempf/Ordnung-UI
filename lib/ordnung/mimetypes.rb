#
# MimeType
#
# representing a file content type
#

require 'ordnung/rom'

module Ordnung
  class MimeType

    def initialize name_or_id
      @@repo ||= Repositories::MimeTypes.new(::Ordnung.rom.container)
      Logger.info "MimeType.new(#{name_or_id.inspect})"
      case name_or_id
      when Integer
        @struct = @@repo.by_id(name_or_id)
        raise "No such mimetype_id #{name_or_id}" unless @struct
      when String
        name = name_or_id
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
