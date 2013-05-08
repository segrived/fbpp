class PrivateMessagesController < ApplicationController
  before_filter :require_auth

  # GET /inbox
  # Отображает список входящих сообщений
  def inbox
    @messages = logged_user.received_messages
      .where(receiver_delete_flag: false)
      .order('sendtime DESC')
    render 'inbox'
  end

  # GET /outbox
  # Отображает список исходящих сообщений
  def outbox
    @messages = logged_user.sended_messages
      .where(sender_delete_flag: false)
      .order('sendtime DESC')
    render 'outbox'
  end

  # GET /messages/:id
  # Отобращает сообщение
  def read
    @message = PrivateMessage.where(id: params[:id]).first!
    # Если сообщение входящее
    if logged_user.id == @message.receiver_id then
      @type = :inbox
      unless @message.read then
        @message.update_attributes({ read: true })
      end
    # Если сообщение исходящее
    elsif logged_user.id == @message.sender_id
      @type = :outbox
    else
      render_403
    end
  end

  # DELETE /message/:id/delete
  # Удаляет указанное сообщение
  def delete
    message = PrivateMessage.find(params[:id])
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
      elsif params[:id] then
        # Ошибка, если сообщения с указанным ID не существует
        pm = PrivateMessage.find(params[:id])
        # Ошибка, в случае, если указанное сообщение пришло не авторизированному пользователю
        # либо сообщение пришло с системного аккаунта, либо аккаунт отправителя был удалён
        if pm.receiver_id != logged_user.id || pm.sender_id == User::SYSTEM_ACCOUNT_ID then
          render_403 and return
        end
        @login = pm.sender.login
        m = /(Re: )*(?<topic>.*)/.match(pm.title)
        @private_message.title = "Re: #{m[:topic]}"
      end
    elsif request.post?
      @private_message = PrivateMessage.new(params[:private_message])
      # Получатель сообщения
      receiver = User.where(login: request[:login]).first
      @login = request[:login]
      # Нельзя отправить сообщение несуществующему пользователю
      if ! receiver || receiver.removed || receiver.banned  then
        @private_message.errors[:base] << t('private_messages.user_not_exists')
        render 'new' and return
      end
      # Нельзя отправить сообщение самому себе
      if receiver.id == logged_user.id then
        @private_message.errors[:base] << t('private_messages.self_send')
        render 'new' and return
      end
      @private_message.sender_id = logged_user.id
      @private_message.receiver_id = receiver.id
      redirect_to :outbox and return if @private_message.save
    end
  end

end