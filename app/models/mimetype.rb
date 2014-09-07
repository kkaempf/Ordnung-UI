#
# Mimetype
#

class Mimetype
  include Mongoid::Document
  
  field :name, :type => String
  has_many :fileextensions, :class_name => "Fileextension"
  has_many :items, :class_name => "Item"

  def to_s
    "Mimetype #{self.name}"
  end

end
