class Lecturer < ActiveRecord::Base
  belongs_to :user
  belongs_to :departament
  belongs_to :scientific_degree
  has_many :comments
  has_many :subject_subscriptions

  attr_accessible :user_id, :scientific_degree_id, :departament_id, :confirm_level

  # Уровни подтверждения аккаунта
  CONFIRM_LEVELS = { unconfirmed: 0, existence: 1, real: 2 }
  CONFIRM_LEVELS.each do |k, v|
    define_method("#{k}?") { confirm_level == CONFIRM_LEVELS[k] }
  end

  def subscribed?(subject_id)
    subject_subscriptions.where(subject_id: subject_id).count > 0
  end

  # Возвращает полное ФИО преподавателя (например: Иванов Андрей Петрович)
  def full_name
    "#{user.surname.cap_first} #{user.name.cap_first}  #{user.patronymic.cap_first}"
  end

  # Возвращает короткое ФИО преподавателя (например: Иванов А. П.)
  def short_name
    "#{user.surname.cap_first} #{user.name.first.mb_upcase}. #{user.patronymic.first.mb_upcase}."
  end

  validates :user_id,
    :presence => true
  validates :scientific_degree_id, :departament_id,
    :existence => { :allow_nil => true }
  validates :confirm_level,
    :inclusion => { :in => CONFIRM_LEVELS.values }
end
