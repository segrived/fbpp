class Lecturer < ActiveRecord::Base
  belongs_to :user
  belongs_to :departament
  attr_accessible :degree, :user_id, :departament_id
end
