class Subject < ActiveRecord::Base
  belongs_to :departament
  attr_accessible :departament_id, :description, :name

  validates :name, :presence => true, :uniqueness => true
  validates :departament, :existence => true
end