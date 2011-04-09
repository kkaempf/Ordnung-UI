class DirectoryController < ApplicationController
  def index
    @dir = params[:dir] || "/"
    @dir = "/" unless File.directory?(@dir)
    @directories = []
    @files = []
#    $stderr.puts "Opening directory #{@dir}"
    Dir.open(@dir).each do |f|
      next if f == "."
      next if f == ".."
      if File.directory? File.join(@dir,f)
#	$stderr.puts "Dir #{f}"
	@directories << f
      else
#	$stderr.puts "File #{f}"
	@files << f
      end
    end
  end

end
