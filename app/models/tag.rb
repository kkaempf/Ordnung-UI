#
# Tag
#

class Tag
  include Mongoid::Document
  
  field :name, :type => String
  field :value, :type => String

  def to_s
    self.value ? "Tag #{self.name}=#{self.value}" : "Tag #{self.name}"
  end

end
