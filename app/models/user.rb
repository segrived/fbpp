class User < ActiveRecord::Base
  attr_accessible :login, :banned, :disabled, :regdate, :account_type
  attr_accessible :name, :surname, :patronymic, :birthday
  attr_accessible :password_hash, :password_salt, :password, :password_confirmation

  attr_accessor :password

  ACCTYPES = { :admin => 0, :mod => 1, :student => 2, :lecturer => 3 }
  ACCTYPES.each do |k, v|
    define_method("#{k}?") { account_type == ACCTYPES[k] }
  end

  # Логин: длина не менее 3 символов, должен быть уникальным, должен состоять
  # только из цифр, букв латинского алфавита и символов подчеркивания
  validates :login,
    :length => { :minimum => 3 },
    :uniqueness => true,
    :format => { :with => /^[a-zA-Z][a-zA-Z_\d]*$/ }
  # Имя, фамилия, отчество, тип аккаунта - должны быть указаны
  validates :name, :surname, :patronymic, :account_type,
    :presence => true
  # Тип аккаунта: либо студент, либо преподаватель
  validates :account_type,
    :inclusion => { :in => [ ACCTYPES[:student], ACCTYPES[:lecturer] ] }
  # Пароль должен быть длиной от 6 до 30 символов и совпадать с подтверждением
  validates :password,
    :length => { :in => 6 .. 30 },
    :confirmation => true

  # Авторизирует пользователя; в случае удачи возвращает пользователя, иначе возвращает nil
  def self.authenticate(login, password)
    user = find_by_login(login)
    return nil unless user
    ph, ps = user.password_hash, user.password_salt
    if ph == BCrypt::Engine.hash_secret(password, ps) then user else nil end
  end

  # Определяет функции, выполняемые во время создания записи нового пользователя
  before_create :encrypt_password, :set_register_date, :give_access

  # Шифрование пароля
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      password = password_confirmation = nil
    end
  end

  # Установка времени регистрации
  def set_register_date
    self.regdate = Time.now
  end

  # По умолчанию создает аккаунт как не забаненный и не отключенный
  def give_access
    self.banned = false
    self.disabled = false
    true
  end

end