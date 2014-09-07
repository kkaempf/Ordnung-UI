#
# Mimetype
#

class Mimetype
  include Mongoid::Document
  
  field :name, :type => String
  has_many :fileextensions
  belongs_to :item

  def to_s
    "Mimetype #{self.name}"
  end

end
