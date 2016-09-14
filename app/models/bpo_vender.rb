class BpoVender < ActiveRecord::Base
  has_and_belongs_to_many :phones
  validates :name, :presence => true
end
