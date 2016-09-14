class Freetext < ActiveRecord::Base
	belongs_to :member
  
  has_and_belongs_to_many :members
  
  validates :type_of, :text, :presence => true
  validates :type_of, numericality: { only_integer: true }
  validates_uniqueness_of :member_id, :scope => :type_of
    
  TypeOf = {:category => 1, :emp_type => 2, :location => 3, :education => 4}
  
  def get_type_of
    case self.type_of
    when 1
      return "category"
    when 2
      return "employer type"
    when 3
      return "location"
    when 4
      return "education"
    else
      return "Unknown"
    end
  end
end
