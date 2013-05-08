class Departament < ActiveRecord::Base
  has_many :lecturers
  has_many :subjects
  attr_accessible :name, :description

  validates :name, :description, presence: true
end
