#
# File extension
#

class Fileextension
  include Mongoid::Document
  
  field :name, :type => String
  belongs_to :mimetype

  def to_s
    "Filetype #{self.name}"
  end

end
