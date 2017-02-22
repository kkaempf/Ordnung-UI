# ordnung/import.rb
#
# import component
#

module Ordnung
  class Ordnung
    
    EXCLUDE_PATTERNS = [ ".git", /.*~/ ]

    def import path, entry = nil
      if entry
        from = File.join(path, entry)
      else
        from = path
        entry = path
      end
      EXCLUDE_PATTERNS.each do |exclude_pattern|
        case exclude_pattern
        when ::String
          return if entry == exclude_pattern
        when ::Regexp
          return if entry =~ exclude_pattern
        else
          logger.error "Unsupported exclude_pattern #{exclude_pattern.inspect}"
        end
      end
      puts "Import from #{from.inspect}" if DEBUG
      begin
        stat = File.stat(from)
        if stat.readable?
          return _import_directory from if stat.directory?
          return _import_file path, entry if stat.file?
          logger.error "Not a file or directory: #{from.inspect}"
        else
          logger.error "Unreadable: #{from.inspect}"
        end
      rescue Exception => e
        logger.error "Can't stat #{from.inspect}: #{e}"
      end
      nil
    end
private
    #
    # import directory
    #
    def _import_directory path
      puts "Importing directory #{path}" if DEBUG
      Dir.open path do |dir|
        dir.each do |entry|
          next if entry == "."
          next if entry == ".."
          import path, entry
        end
      end
      true
    end
    #
    # import file
    #
    def _import_file path, entry = nil
      puts "Importing file #{path}/#{entry}" if DEBUG
    end
  end
end
