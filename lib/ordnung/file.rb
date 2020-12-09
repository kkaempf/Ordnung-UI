#
# File
#
# representing a file
#
#

require 'ordnung/rom'

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

    attr_reader :id, :name, :extension, :directory
    def initialize pathname
      Logger.info "File.new"
      @@rom ||= ROM.new
      if ::File.directory?(pathname)
        raise "Is a directory"
      end
      unless ::File.readable?(pathname)
        raise "Is not readable"
      end
      @pathname = pathname
      @name = ::File.basename(pathname)
      @extension = ::File.extname(@name)
      if @extension[0,1] == '.'
        @extension = @extension[1..-1] # strip dot from extension
      end
      @directory = ::File.dirname(pathname).delete_prefix(@@strip)
      @id = File.repo.id(self)
      unless @id
        f = File.repo.create(name: @name, extension: @extension, directory: @directory)
        @id = f.id
      end
    end

    def self.repo
      @@repo ||= Repositories::Files.new(@@rom.container)
    end
    def save
      if @id
        Logger.info "File.save update #{self.inspect}"
        # update
      else
        Logger.info "File.save new #{self.inspect}"
        f
      end
    end
  end
end
