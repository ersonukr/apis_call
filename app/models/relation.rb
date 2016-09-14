class Relation < ActiveRecord::Base
	belongs_to :member
  belongs_to :phone
  
  Relationship = {:self => 0, :father => 1, :mother => 2, :husband => 3, :wife => 4, :brother => 5, :sister => 6, :son => 7, :daughter => 8, :relative => 9, :friend => 10, :alternative => 11 }
  
  default_scope -> { where.not(:relation_type => nil) }
  
  def to_s
    "#{relation_type}"
  end
  def member
    Member.unscoped{ super }
  end
end
