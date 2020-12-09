#
# Directory
#
# representing a directory
#
# implemented as (backwards-)linked list of path elements
#   effectively representing a directory tree
#
#

require 'ordnung/rom'

module Ordnung
  class Directory

    attr_reader :id, :name, :parent
    def initialize pathname
      Logger.info "Directory.new"
      unless ::File.directory?(pathname)
        raise "Is no directory"
      end
      @id = nil
      pathname.split(::File::SEPARATOR).each do |element|
        next if element.empty?
        @name = element
        @parent = @id
        Logger.info "Element #{@name.inspect}, parent #{@parent.inspect}"
        @id = Directory.repo.id(self)
        Logger.info "  repo.id #{@id.inspect}"
        next if @id
        Logger.info "Create !"
        d = Directory.repo.create(name: @name, parent: @parent)
        @id = d.id
      end
    end

    def self.repo
      @@repo ||= Repositories::Directories.new(::Ordnung.rom.container)
    end
  end
end
