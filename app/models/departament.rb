class Departament < ActiveRecord::Base
  has_many :lecturers
  attr_accessible :name, :description

  validates :name, :description,
    :presence => true
end
