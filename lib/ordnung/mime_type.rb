#
# ordnung/mime_type
#
# mime type handling for Ordnung
#
module Ordnung
  class MimeType
    def self.detect location
      @@mime_types ||= self.load Config.mimetypes
      *names, ext = location.split '.'
#      puts "Ext #{ext.inspect}"
      @@mime_types[ext] || "application/octet-stream"
    end
    private
    def self.load mimetypes
      mt_hash = Hash.new
      unless mimetypes.is_a? Array
        mimetypes = Array(mimetypes)
      end
      mimetypes.each do |mt|
        case mt
        when String
          # assume file in config/
          begin
            path = File.join(TOPLEVEL, "config", mt)
            File.open(path) do |f|
              f.each do |l|
                case l
                when/^\#/
                  next
                when /^([^\s]+)\s+([^\n]+)\n$/
                  mtype = $1
                  $2.split(' ').each do |ext|
                    if mt_hash[ext]
                      Logger.warn "Extension clash for #{ext}: #{mt_hash[ext]} vs. #{mtype}"
                    else
                      mt_hash[ext] = mtype
                    end
                  end
                else
                  raise "Unrecognizable entry in #{path}: #{l.inspect}"
                end
              end
            end
          rescue Exception => e
            Logger.error "Can't read mime type file #{path}: #{e}"
          end
        when Hash
          # assume { extension: mime_type }
        else
          raise "Unknown entry in Config[:mimetypes]: #{mt.inspect}"
        end        
      end # mimetypes.each
      mt_hash
    end # self.load
  end
end
