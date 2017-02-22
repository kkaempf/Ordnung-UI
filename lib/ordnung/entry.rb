#
# ordnung/entry
#
# Generic database entry for Ordnung
#

module Ordnung
  class Entry
    attr_reader :hash, :location, :mimetype, :tags
    #
    # Create new entry in memory
    # Must call entry.save! to put it in database
    #
    # @param location  - if nil, read content from stdin
    #                    else assume path to file
    #
    def initialize location = nil
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
      @data[:hash] = @hash
      raise "Entry without mime type during save" unless @mimetype
      @data[:mimetype] = @mimetype
      ::Ordnung.database.write @data
    end
  end
end
