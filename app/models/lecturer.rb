class Lecturer < ActiveRecord::Base
  belongs_to :user
  belongs_to :departament
  belongs_to :scientific_degree

  attr_accessible :user_id, :scientific_degree_id, :departament_id

  # Возвращает данные преподавателя по ID пользователя
  def self.get_by_uid(user)
    Lecturer.where(:user_id => user.id).first
  end
end
