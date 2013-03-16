class User < ActiveRecord::Base
  attr_accessible :login, :banned, :disabled, :regdate, :account_type
  attr_accessible :name, :surname, :patronymic, :birthday
  attr_accessible :password_hash, :password_salt, :password, :password_confirmation

  attr_accessor :password, :password_confirmation

  ACCTYPES = { :admin => 0, :mod => 1, :student => 2, :lecturer => 3 }
  ACCTYPES.each do |k, v|
    define_method("#{k}?") {
      account_type == ACCTYPES[k]
    }
  end

  # Проверяемые правила
  validates :login,
    :length => { :minimum => 3 },
    :uniqueness => true,
    :format => { :with => /^[a-zA-Z\d]*$/ }
  validates :name, :surname, :patronymic, :account_type,
    :presence => true
  validates :account_type, :inclusion => {
    :in => [ ACCTYPES[:student], ACCTYPES[:lecturer] ]
  }
  validates :password, :length => { :in => 5 .. 20 }

  def self.authenticate(login, password)
    user = find_by_login(login)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt) then user else nil end
  end

  before_save :encrypt_password, :set_register_date, :give_access

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