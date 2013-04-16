class PrivateMessagesController < ApplicationController
  before_filter :require_auth

  # GET /inbox
  # Отображает список входящих сообщений
  def inbox
    @messages = logged_user.received_messages
      .where(receiver_delete_flag: false)
      .order('sendtime DESC')
    @type = 'inbox'
    render 'messages'
  end

  # GET /outbox
  # Отображает список исходящих сообщений
  def outbox
    @messages = logged_user.sended_messages
      .where(sender_delete_flag: false)
      .order('sendtime DESC')
    @type = 'outbox'
    render 'messages'
  end

  # GET /message/1
  # Отобращает сообщение
  def read
    @message = PrivateMessage.where(id: params[:message_id]).first!
    # Если сообщение входящее
    if logged_user.id == @message.receiver_id then
      @type = 'inbox'
      unless @message.read then
        @message.update_attributes({ read: true })
      end
    # Если сообщение исходящее
    elsif logged_user.id == @message.sender_id
      @type = 'outbox'
    else
      render_403
    end
  end

  # DELETE /message/1/delete
  # Удаляет указанное сообщение
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
  # Отображает форму создания нового сообщения
  #
  # POST /message/new
  # Создает новое личное сообщение
  def new
    if request.get? then
      @private_message = PrivateMessage.new
      if params[:login] then
        @login = params[:login]
      elsif params[:mid] then
        # Ошибка, если сообщения с указанным ID не существует
        pm = PrivateMessage.find(params[:mid])
        # Ошибка, в случае, если указанное сообщение пришло не авторизированному пользователю
        # либо сообщение пришло с системного аккаунта, либо аккаунт отправителя был удалён
        if pm.receiver_id != logged_user.id || pm.sender_id == User::SYSTEM_ACCOUNT_ID || pm.sender == nil then
          redirect_to :inbox and return
        end
        @login = pm.sender.login
        m = /(Re: )*(?<topic>.*)/.match(pm.title)
        @private_message.title = "Re: #{m[:topic]}"
      end
    elsif request.post?
      @private_message = PrivateMessage.new(params[:private_message])
      # Получатель сообщения
      receiver = User.where(login: request[:login]).first
      # Нельзя отправить сообщение несуществующему пользователю
      if ! receiver || receiver.removed  then
        @private_message.errors[:base] << t('messages.selected_user_not_exists')
        @login = request[:login]
        render 'new' and return
      end
      # Нельзя отправить сообщение самому себе
      if receiver.id == logged_user.id then
        @private_message.errors[:base] << t('messages.send_message_self')
        render 'new' and return
      end
      @private_message.sender_id = logged_user.id
      @private_message.receiver_id = receiver.id
      redirect_to :outbox and return if @private_message.save
    end
  end

end