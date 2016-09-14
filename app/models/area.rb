class Area < ActiveRecord::Base
	belongs_to :city
  has_many :locations
  has_many :addresses
  has_many :members, :through => :addresses

  has_many :phones
end
