class PrivateMessage < ActiveRecord::Base
  belongs_to :sender,   :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'

  attr_accessible :sender_id, :receiver_id
  attr_accessible :body, :read, :sendtime, :title
  attr_accessible :sender_delete_flag, :receiver_delete_flag

  validates :sender_id, :receiver_id,
    :presence => true
  validates :title, :body,
    :presence => true
  
  before_create :set_sendtime, :mark_unread
  after_save :remove_deleted_messages

  private

  # Устанавливает дату отправления
  def set_sendtime
    self.sendtime = Time.now
  end

  # Помечает сообщение непрочитанным
  def mark_unread
    self.read = false
    true
  end

  # Удаляет из БД сообщения удалённые обоими пользователями
  def remove_deleted_messages
    PrivateMessage
      .where(:sender_delete_flag => true)
      .where(:receiver_delete_flag => true)
      .destroy_all
  end

end