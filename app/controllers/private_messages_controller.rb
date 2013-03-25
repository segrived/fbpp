class PrivateMessagesController < ApplicationController
  before_filter :require_login

  def inbox
    @messages = PrivateMessage.where('receiver_id = ?', logged_user.id)
    render 'messages'
  end

  def outbox
    @messages = PrivateMessage.where('sender_id = ?', logged_user.id)
    render 'messages'
  end

  def read
    @message = PrivateMessage
      .where('id = ?', params[:message_id])
      .where('receiver_id = :id OR sender_id = :id', :id => logged_user.id)
      .first
    unless @message then
      redirect_to :messages_inbox and return
    end
    if @message.receiver_id == logged_user.id && !@message.read then
      @message.read = true
      @message.save
    end
  end

  def new
    @receiver = User.find_by_id(params[:receiver_id])
    # Если указанный пользователь не найден - редирект в инбокс
    unless @receiver then
      redirect_to :messages_inbox and return
    end
    # Если пользователь пытается отправить сообщение сам себе - редирект в инбокс
    if @receiver.id == logged_user.id
      redirect_to :messages_inbox and return
    end
    # В случае GET-запроса
    if request.get? then
      @private_message = PrivateMessage.new
    # В случае POST-запроса
    elsif request.post? then
      @private_message = PrivateMessage.new(params[:private_message])
      @private_message.sender_id = logged_user.id
      @private_message.read = false
      if @private_message.save then
        redirect_to :messages_inbox and return
      else
        @receiver = User.find_by_id(params[:private_message][:receiver_id])
      end
    end
  end

end