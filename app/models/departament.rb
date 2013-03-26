class Departament < ActiveRecord::Base
  has_many :lecturers
  attr_accessible :description, :name
end
