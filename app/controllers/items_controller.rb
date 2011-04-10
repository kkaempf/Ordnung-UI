#
# RESTful controller for Items
#
class ItemsController < ApplicationController
  def new
  end
  
  def create
    dir = params[:dir]
    recursive = params[:recursive]
    if dir
      # import directory
      unless File.directory?(dir)
	redirect_to "directory", :dir => dir, :alert => "Not a directory '#{dir}"
        return
      end
      Dir.open(dir) do |d|
	d.each do |file|
	  next if file == "."
	  next if file == ".."
	  unless recursive
	    next if File.directory?(File.join(dir,file))
	  end
	  $stderr.puts "Import #{dir}/#{file}"
	  item = Item.create({
	    :dir => dir,
	    :name => file
	  })
	  $stderr.puts "as item #{item}"
	  item.save
	  $stderr.puts "with checksum #{item.checksum}"
	end
      end
    else
      # import file
      # Parameters: {"commit"=>"ImportFile",
      # "authenticity_token"=>"kSiOIzYrL6NyddrBo2u0Kxv/8MaXIOfxgmMBz5sUj7w=",
      # "utf8"=>"✓",
      # "file"=>#<ActionDispatch::Http::UploadedFile:0x7fd252d17a00
      #         @content_type="application/octet-stream",
      #         @headers="Content-Disposition: form-data;
      #                   name=\"file\";
      #                   filename=\"ReadString.pde\"\r\nContent-Type: application/octet-stream\r\n",
      #                   @original_filename="ReadString.pde",
      #                   @tempfile=#<File:/tmp/RackMultipart20110409-10560-fkjy2z-0>>}
      unless params[:commit] == "ImportFile"
	redirect_to "/", :alert => "Invalid call to ItemsController#create"
        return
      end
      uploaded_file = params[:file]
      unless uploaded_file.is_a? ActionDispatch::Http::UploadedFile
	redirect_to "/", :alert => "ItemsController#create called without uploaded file"
        return
      end
      $stderr.puts "Import #{uploaded_file.original_filename}"
      item = Item.create({
	:name => uploaded_file.original_filename,
	:content => uploaded_file.read
      })
      $stderr.puts "as item #{item}"
      item.save  
      $stderr.puts "with checksum #{item.checksum}"
    end
    redirect_to "/"
  end
end
