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

    def self.pathname(id)
      dir = @@repo[id]
      Directory.new(dir.name, dir.parent, dir.id).pathname
    end
    def self.[] id
      @@repo[id]
    end

    attr_reader :id, :name, :parent
    def initialize dirname, parent = nil, id = nil
      @@repo ||= Repositories::Directories.new(::Ordnung.rom.container)
      if parent && id
        @name = dirname
        @parent = parent
        @id = id
      else
        Logger.info "Directory.new(#{dirname.inspect})"
        @id = nil
        # recursively create directory path elements with
        #   backpointer to parent
        #
        dirname.split(::File::SEPARATOR).each do |element|
          next if element.empty?
          @name = element
          @parent = @id
          Logger.info "Element #{@name.inspect}, parent #{@parent.inspect}"
          @id = @@repo.id(self)
          Logger.info "  repo.id #{@id.inspect}"
          next if @id
          Logger.info "Create !"
          d = @@repo.create(name: @name, parent: @parent)
          @id = d.id
        end
      end
    end

    def pathname
      elements = []
      d = self
      loop do
        elements.unshift d.name
        break if d.parent.nil?
        d = @@repo[d.parent]
      end
      elements.join ::File::SEPARATOR
    end

  end
end
