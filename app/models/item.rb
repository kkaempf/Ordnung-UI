#
# Item with path, file, and checksum
#
require 'digest/sha1'

class Item
  include Mongoid::Document

  @@toplevel = File.expand_path(File.join(File.dirname(__FILE__), "..", ".."))

  field :name, :type => String
  field :filename, :type => String
  belongs_to :mimetype
  field :directory, :type => String
  field :content
  has_and_belongs_to_many :tags, inverse_of: nil

  def initialize(attrs = nil)
    super(attrs)
    #
    # compute Item name
    #  either content is set (uploaded file)
    #  or directory + filename 

    checksum = size = nil
    if self.content
      checksum = Digest::SHA1.hexdigest(content)
      self.directory = self.filename = nil
      size = content.bytesize
    else
      raise "Neither path nor content set" unless self.directory && self.filename
      path = File.join(self.directory, self.filename)
      raise "File #{path} not readable" unless File.readable?(path)
      #	$stderr.puts "Computing checksum for #{path}"
      File.open(path) do |file|
        size = File.size(file)
        checksum = Digest::SHA1.new
        buffer = ''
        while not file.eof
          file.read(512*1024, buffer) # read in 512k chunks
          checksum.update(buffer)
        end
      end
    end
    self.name = "#{checksum},#{size}"
  end

  def duplicate
    begin
      Item.find_by(:id => self.id)
    rescue Mongoid::Errors::DocumentNotFound
      false
    end
  end

  def thumb_dir
    @thumb_dir ||= File.join("thumbnails", self.name[0,2])
  end

  def thumb_file
    thumb_file = File.join(self.thumb_dir, "#{self.name}.jpg")
  end

  def thumb_exists?
    File.exist?(File.join(@@toplevel, "public", self.thumb_file))
  end

  def to_s
    "#{self.filename}:#{self.name}"
  end

end
