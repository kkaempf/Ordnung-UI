#
# File extension
#

class Fileextension
  include Mongoid::Document
  
  field :name, :type => String
  belongs_to :mimetype, :class_name => "Mimetype"

  def to_s
    "Filetype #{self.name}"
  end

end
