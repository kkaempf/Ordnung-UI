#
# Item with path, file, and checksum
#
require 'digest/sha1'

class Item
  include Mongoid::Document
  
  @@toplevel = File.expand_path(File.join(File.dirname(__FILE__), "..", ".."))

  field :name, :type => String
  field :size, :type => Fixnum
  field :sha1sum, :type => String
  belongs_to :mimetype
  field :dir, :type => String
  field :content
  has_and_belongs_to_many :tags, inverse_of: nil

#  attr_accessible :content, :name, :dir

#  attr_protected :checksum
#  validates_presence_of :name
#  validates_presence_of :checksum
  
  before_save :compute_checksum

  def id
    self.checksum
  end

  def checksum
    compute_checksum
    self.sha1sum
  end

  def duplicate
    begin
      Item.find_by(:sha1sum => self.checksum)
    rescue Mongoid::Errors::DocumentNotFound
      false
    end
  end

  def thumb_dir
    @thumb_dir ||= File.join("thumbnails", self.checksum[0,2])
  end

  def thumb_file
    thumb_file = File.join(self.thumb_dir, "#{self.checksum}.jpg")
  end

  def thumb_exists?
    File.exist?(File.join(@@toplevel, "public", self.thumb_file))
  end

  def to_s
    "#{self.name}:#{self.id}"
  end

  private
    #
    # compute file checksum
    #  either content is set (uploaded file)
    #  or dir + name 
    def compute_checksum
      return if self.sha1sum
#      $stderr.puts "#{self}.compute_checksum"
      if self.content
	self.sha1sum = Digest::SHA1.hexdigest(content)
	self.dir = nil
        self.size = content.bytesize
      else
	raise "Neither dir nor content set" unless self.dir
	path = File.join(self.dir, self.name)
	raise "File #{path} not readable" unless File.readable?(path)
#	$stderr.puts "Computing checksum for #{path}"
	File.open(path) do |file|
          self.size = File.size(file)
          sha1 = Digest::SHA1.new
          buffer = ''
          while not file.eof
            file.read(512*1024, buffer) # read in 512k chunks
            sha1.update(buffer)
          end
	  self.sha1sum = sha1
	end
      end
    end
end
