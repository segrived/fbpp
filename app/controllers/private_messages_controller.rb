class PrivateMessagesController < ApplicationController
  before_filter :require_login

  # GET /inbox
  def inbox
    @messages = logged_user.received_messages
      .where(:receiver_delete_flag => false)
      .order('sendtime DESC')
    render 'messages'
  end

  # GET /outbox
  def outbox
    @messages = logged_user.sended_messages
      .where(:sender_delete_flag => false)
      .order('sendtime DESC')
    render 'messages'
  end

  # GET /message/read/14
  def read
    @message = PrivateMessage
      .where(:id => params[:message_id])
      .where('receiver_id = :id OR sender_id = :id', :id => logged_user.id)
      .first
    redirect_to :inbox and return unless @message
    if @message.receiver_id == logged_user.id && !@message.read then
      @message.read = true
      @message.save
    end
  end

  # DELETE /message/delete/14
  def delete
    message = PrivateMessage.find(params[:message_id])
    if message.sender_id == logged_user.id then
      message.sender_delete_flag = true
    elsif message.receiver_id == logged_user.id then
      message.receiver_delete_flag = true
    end
    message.save
    redirect_to :inbox
  end

  # GET /message/new
  def new
    if request.get? then
      @private_message = PrivateMessage.new
      if params[:login] then
        @login = params[:login]
      elsif params[:mid] then
        # Ошибка, если сообщения с указанным ID не существует
        redirect_to :inbox and return unless pmsg = PrivateMessage.find_by_id(params[:mid])
        # Ошибка, в случае, если указанное сообщение пришло не авторизированному пользователю
        if pmsg.receiver_id != logged_user.id or pmsg.sender_id == User::SYSTEM_ACCOUNT_ID then
          redirect_to :inbox and return
        end
        @login = pmsg.sender.login
        @private_message.title = "Re: #{pmsg.title}"
      end
        
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