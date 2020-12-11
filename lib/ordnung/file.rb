#
# File
#
# representing a file
#
#

require 'ordnung/rom'
require 'ordnung/directory'
require 'ordnung/extension'

module Ordnung
  class File
    # path component to strip
    def self.strip= pathname
      @@strip = pathname
      unless @@strip[-1,1] == ::File::SEPARATOR
        @@strip << ::File::SEPARATOR
      end
    end
    def self.strip
      @@strip
    end
    private
    def create_from_id id
      @@repo[id]
    end
    def create_from_pathname pathname
      if ::File.directory?(pathname)
        raise "Is a directory"
      end
      unless ::File.readable?(pathname)
        raise "Is not readable"
      end
      name = ::File.basename(pathname)
      extension_id = Extension.new(::File.extname(pathname)).id
      directory_id = Directory.new(::File.dirname(pathname).delete_prefix(@@strip)).id
      f = @@repo[name, extension_id, directory_id]
      unless f
        f = @@repo.create(name: name, extension_id: extension_id, directory_id: directory_id)
        @created = true
      end
      f
    end
    public
    def initialize arg
      @@repo ||= Repositories::Files.new(::Ordnung.rom.container)
      Logger.info "File.new"
      @struct = case arg
      when Integer
        create_from_id arg
      when String
        create_from_pathname arg
      else
        raise "Unknown argument #{arg.class}:#{arg.inspect}"
      end
    end

    def id
      @struct.id
    end
    def name
      @struct.name
    end
    def extension
      Extension.new(@struct.extension_id).name
    end
    def directory
      Directory.pathname(@struct.directory_id)
    end
    def created?
      @created
    end
  end
end
