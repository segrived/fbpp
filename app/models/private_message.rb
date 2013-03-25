class PrivateMessage < ActiveRecord::Base
  belongs_to :sender,   :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'

  attr_accessible :sender_id, :receiver_id
  attr_accessible :body, :read, :sendtime, :title

  validates :sender_id, :receiver_id,
    :presence => true
  validates :title, :body,
    :presence => true
  
  before_create :set_sendtime, :mark_unread

  def set_sendtime
    self.sendtime = Time.now
  end

  def mark_unread
    self.read = false
    true
  end

end