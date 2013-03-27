class PrivateMessagesController < ApplicationController
  before_filter :require_login

  # [GET] /inbox
  def inbox
    @messages = logged_user.received_messages
    render 'messages'
  end

  # [GET] /outbox
  def outbox
    @messages = logged_user.sended_messages
    render 'messages'
  end

  def read
    @message = PrivateMessage
      .where('id = ?', params[:message_id])
      .where('receiver_id = :id OR sender_id = :id', :id => logged_user.id)
      .first
    unless @message then
      redirect_to :inbox and return
    end
    if @message.receiver_id == logged_user.id && !@message.read then
      @message.read = true
      @message.save
    end
  end

  def new
    @receiver = User.find_by_id(params[:receiver_id])
    if @receiver == nil || @receiver.id == logged_user.id then
      redirect_to :inbox and return
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
        redirect_to :outbox and return
      else
        @receiver = User.find_by_id(params[:private_message][:receiver_id])
      end
    end
  end

end