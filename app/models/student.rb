class Student < ActiveRecord::Base
  belongs_to :user
  belongs_to :specialty
  attr_accessible :course, :user_id, :specialty_id

  def self.get_by_uid(user)
    Student.where(:user_id => user.id).first
  end
end