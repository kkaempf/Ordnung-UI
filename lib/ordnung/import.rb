# ordnung/import.rb
#
# import component
#

module Ordnung
  class Ordnung
    
    EXCLUDE_PATTERNS = [ ".git", /.*~/ ]

    def import path, entry = nil
      path = File.expand_path(path)
      if entry
        from = File.join(path, entry)
      else
        from = path
        entry = File.basename(path)
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
#      puts "Import from #{from.inspect}" if DEBUG
      begin
        stat = File.stat(from)
      rescue Exception => e
        logger.error "Can't stat #{from.inspect}: #{e} @ #{e.backtrace[0]}"
        return
      end
      if stat.readable?
        return _import_directory from if stat.directory?
        return _import_file File.join(path, entry) if stat.file?
        logger.error "Not a file or directory: #{from.inspect}"
      else
        logger.error "Unreadable: #{from.inspect}"
      end
      nil
    end
private
    #
    # import directory
    #
    def _import_directory path
#      puts "Importing directory #{path}" if DEBUG
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
    def _import_file path
      puts "Importing file #{path}" if DEBUG
      entry = Entry.new path
      entry.tags = path.split File::SEPARATOR
      entry.tags.shift if entry.tags[0].empty?
      puts "Entry: #{entry}"
      entry.save
    end
  end
end
