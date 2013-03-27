class PrivateMessagesController < ApplicationController
  before_filter :require_login

  # [GET] /inbox
  def inbox
    @messages = logged_user.received_messages.order('sendtime DESC')
    render 'messages'
  end

  # [GET] /outbox
  def outbox
    @messages = logged_user.sended_messages.order('sendtime DESC')
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
    if request.get? then
      @private_message = PrivateMessage.new
      @login = params[:login] if params[:login]
    elsif request.post?
      @private_message = PrivateMessage.new(params[:private_message])
      unless receiver = User.find_by_login(request[:login]) then
        @private_message.errors[:base] << t('messages.selected_user_not_exists')
        @login = request[:login]
        render 'new' and return
      end
      @private_message.sender_id = logged_user.id
      @private_message.receiver_id = receiver.id
      @private_message.read = false
      redirect_to :outbox and return if @private_message.save
    end

  end

end