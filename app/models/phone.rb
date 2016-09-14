class Phone < ActiveRecord::Base
	belongs_to :area
  has_many :relations, :dependent => :destroy
  has_many :members, :through => :relations
  has_and_belongs_to_many :bpo_venders
  
end
