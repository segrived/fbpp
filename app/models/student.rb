class Student < ActiveRecord::Base
  belongs_to :user
  belongs_to :specialty
  
  attr_accessible :course, :user_id, :specialty_id

  # Максимально доступный курс
  MAX_COURSE = 5

  validates :user_id,
    :presence => true
  validates :specialty_id,
    :existence => { :allow_nil => true }
  validates :course,
    :inclusion => { :in => 1 .. MAX_COURSE },
    :allow_nil => true

  # Возвращает данные студента по ID пользователя
  def self.get_by_user(user)
    Student.where(:user_id => user.id).first
  end
end