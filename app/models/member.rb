class Member < ActiveRecord::Base
	has_many :salaries, :dependent => :destroy
  has_many :experiences, :dependent => :destroy
  
  has_many :addresses, :dependent => :destroy
  
  has_many :relations, :dependent => :destroy
  has_many :phones, :through => :relations
  
  has_many :locations, :through => :addresses
  has_many :areas, :through => :addresses

  has_and_belongs_to_many :educations
  has_and_belongs_to_many :categories

  has_and_belongs_to_many :emp_types
  has_and_belongs_to_many :freetexts
end
