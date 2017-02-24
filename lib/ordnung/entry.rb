#
# ordnung/entry
#
# Generic database entry for Ordnung
#

module Ordnung
  class Entry
    attr_reader :hash, :location, :mimetype, :tags, :id, :ctime, :mtime, :size, :name
    #
    # Create new entry in memory
    # Must call entry.save! to put it in database
    #
    # @param location  - if nil, read content from stdin
    #                    else assume path to file
    #
    def initialize stat, location = nil
      @data = Hash.new
      @tags = nil
      if location
        begin
          IO.popen(["sha256sum", location]) do |io|
            @hash = io.read.split(' ')[0]
          end
        rescue Exception => e
          logger.error "Can't hash #{location.inspect}: #{e}"
        end
        @mimetype = MimeType.detect location
        @location = location
        @ctime = stat.ctime
        @mtime = stat.mtime
        @size = stat.size
        tags = location.split File::SEPARATOR
        tags.shift if tags[0].empty?
        @name = tags.pop
        @tags = tags
      else
        stdin
      end
    end
    def mimetype= mt
      @mimetype = mt
    end
    #
    # string representation
    #
    def to_s
      "#{@hash}:#{@mimetype}@#{@location}"
    end
    #
    # read data from stdin
    #
    def stdin
      raise "Not implemented"
    end
    #
    # set tags
    #
    def tags= tag
      case tag
      when Array
        @tags = tag
      when String
        @tags = [tag]
      else
        @tags = [tag.to_s]
      end
    end
    #
    # save entry to database
    #
    def save
      raise "Unhashed entry during save" unless @hash
      raise "Entry without mime type during save" unless @mimetype
      @data[:mimetype] = @mimetype
      @data[:ctime] = @ctime.utc.to_i
      @data[:mtime] = @mtime.utc.to_i
      @data[:name] = @name
      @data[:size] = @size
      @data[:tags] = @tags
      @data[:locations] ||= Array.new
      unless @data[:locations].include? @location
        @data[:locations] << @location
      end
      if ::Ordnung.database.read @hash
        ::Ordnung.database.update @hash, @data
      else
        ::Ordnung.database.create @hash, @data
      end
      @hash
    end
  end
end
