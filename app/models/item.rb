#
# Item with path, file, and checksum
#
require 'digest/sha1'

class Item
  include Mongoid::Document
  
  field :name, :type => String
  field :dir, :type => String
  field :content
  field :checksum, :type => String
  
  attr_accessible :content, :name, :dir

  attr_protected :checksum
#  validates_presence_of :name
#  validates_presence_of :checksum
  
  before_save :compute_checksum

  def id
    self.checksum
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
#      $stderr.puts "#{self}.compute_checksum"
      if self.content
	self.checksum = Digest::SHA1.hexdigest(content)
	self.dir = nil
      else
	raise "Neither dir nor content set" unless self.dir
	path = File.join(self.dir,self.name)
	raise "File #{path} not readable" unless File.readable?(path)
#	$stderr.puts "Computing checksum for #{path}"
	File.open(path) do |f|
	  # fixme, do partial reads for large files
	  self.checksum = Digest::SHA1.hexdigest(f.read)
	end
      end
    end
end
