class Address < ActiveRecord::Base
	belongs_to :member
  belongs_to :location
  belongs_to :area
  belongs_to :city

  Location_type = {:location => 1, :area => 2, :city => 3}
end
