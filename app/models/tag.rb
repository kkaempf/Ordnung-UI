#
# Tag
#

class Tag
  include Mongoid::Document
  
  field :name, :type => String
  field :value, :type => String

  def to_s
    self.value ? "#{self.name}=#{self.value}" : "#{self.name}"
  end

end
