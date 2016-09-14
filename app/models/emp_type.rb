class EmpType < ActiveRecord::Base
  has_and_belongs_to_many :members
  validates :title, presence: true, uniqueness: true
end
