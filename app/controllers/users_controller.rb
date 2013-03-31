class UsersController < ApplicationController

  before_filter :shouldnt_have_admin_account, :only => :create_admin_account

  # GET /register
  # Отобрражает форму регистрации
  def new
    @user = User.new
    render :register
  end

  # POST /register
  # Создает аккаунт по введённым данным
  def create
    @user = User.new(params[:user])
    # Пользователь не может создать аккаунт администраторы или модератора
    if User.in_admin_group?(@user) then
      redirect_to :login, :notice => t('messages.invalid_operation') and return
    end
    # Если запись успешно создана
    if @user.save then
      # Создание записи в дополнительной таблице
      if @user.student? then
        Student.create(user_id: @user.id)
      elsif @user.lecturer? then
        Lecturer.create(user_id: @user.id, confirm_level: Lecturer::CONFIRM_LEVELS[:unconfirmed])
      end
      login, password = params[:user][:login], params[:user][:password]
      session[:user_id] = User.authenticate(login, password).id
      redirect_to :my_options
    else
      render :register
    end
  end

  # GET /create_admin
  # Отображает форму создания аккаунта администратора
  #
  # POST /create_admin
  # Создает аккаунт администратора
  def create_admin_account
    if request.get? then
      @user = User.new
    elsif request.post? then
      @user = User.new(params[:user])
      @user.account_type = User::ACCTYPES[:admin]
      login, password = params[:user][:login], params[:user][:password]
      if @user.save then
        session[:user_id] = User.authenticate(login, password).id
        redirect_to :root
      end
    end
  end

  # GET /users/:filter/(:page)
  # Оторажает страницу со списком пользователей
  def list
    filter = params[:filter] ? params[:filter].to_sym : :all
    unless User::ACCTYPES.include?(filter) || filter == :all then
      redirect_to users_path(:all) and return
    end
    page = params[:page] || 1
    # Разбивка списка пользователей на страницы
    @users = User.paginate(page: page, per_page: 10)
    if filter != :all
      @users = @users.where(account_type: User::ACCTYPES[filter])
    end
    # Дабы не отображать удалённых пользователей
    @users = @users.where(removed: false)
  end

end