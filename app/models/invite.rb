class Invite < ActiveRecord::Base
  attr_accessible :code, :expires, :remains

  validates :code, uniqueness: true
  validates :remains, inclusion: { in: 0..1000 }

  def self.use(code)
    @invite = Invite.where(code: code).first.decrement!(:remains)
  end

  def self.valid?(code)
    Invite
      .where(code: code)
      .where('remains > ?', 0)
      .where('expires > ? OR expires IS NULL', DateTime.now)
      .count > 0
  end

  def self.generate_new
    SecureRandom.hex 16
  end
end
