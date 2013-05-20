class Specialty < ActiveRecord::Base
  attr_accessible :code, :description, :name

  validates :code, :name, :description,
    :presence => true
end
