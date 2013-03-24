class Lecturer < ActiveRecord::Base
  belongs_to :user
  belongs_to :departament
  belongs_to :scientific_degree

  attr_accessible :user_id, :scientific_degree_id, :departament_id, :confirm_level

  CONFIRM_LEVELS = { :unconfirmed => 0, :existence => 1, :real => 2 }
  CONFIRM_LEVELS.each do |k, v|
    define_method("#{k}?") { confirm_level == CONFIRM_LEVELS[k] }
  end

  validates :user_id,
    :presence => true
  validates :scientific_degree_id, :departament_id,
    :existence => { :allow_nil => true }
  validates :confirm_level,
    :inclusion => { :in => CONFIRM_LEVELS.values }

  # Возвращает данные преподавателя по ID пользователя
  def self.get_by_user(user)
    Lecturer.where(:user_id => user.id).first
  end
end
