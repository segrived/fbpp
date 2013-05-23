class UsersController < ApplicationController

  before_filter :shouldnt_have_admin_account, only: [:create_admin]
  before_filter :require_not_auth, only: [:register, :login]
  before_filter :disable_sidebar!, only: [:register, :login, :create_admin]
  before_filter :require_admin_account, only: [:mods]

  # GET /register
  # POST /register
  def register
    if request.get? then
      @user = User.new
    end
    # Запрос на создание нового пользователя
    if request.post? then
      @user = User.new(params[:user])
      # Пользователь может создать только аккаунт студента или преподавателя
      unless User.in_user_group?(@user) then
        render_403 and return
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
        if @user.lecturer? then
          redirect_to settings_lecturer_path(reg: 1)
        elsif @user.student? then
          redirect_to settings_student_path(reg: 1)
        else
          redirect_to :root
        end
      else
        render :register
      end
    end
  end

  # GET /login
  # Отоборажает форму авторизации пользователя
  #
  # POST /login
  # Пытается авторизировать пользователя на основе введённых данных
  def login
    # Если пришел GET-запрос - просто отображаем форму
    render :login and return if request.get?
    # Пытаемся авторизироваться на основе введённых данных
    login, password = params[:login], params[:password]
    # Если логин или пароль не совпали с правильными значениями
    unless user = User.authenticate(login, password) then
      redirect_to :login, notice: t('users.invalid_login') and return
    end
    # Если аккаунт пользователя удалён
    if user.removed then
      redirect_to :login, notice: t('users.removed_account') and return
    end
    # Ели пользователь забанен
    if user.banned then
      redirect_to :login, notice: t('users.banned') and return
    end
    # В случае успешной авторизации запоминаем пользователя и перебрасываем
    # его на главную страницу
    session[:user_id] = user.id
    redirect_to (params[:back] != nil) ? :back : :root
  end

  def profile
    render_403 and return unless (params[:login] || logged?)
    login = params[:login] || logged_user.login
    @user = User.where(login: login).first!
    if @user.lecturer? then
      @lecturer = @user.lecturer
      render 'profiles/lecturer'
    elsif @user.student? then
      render 'profiles/student'
    else
      render 'profiles/common'
    end
  end

  def list
    page = params[:page] || 1
    # Разбивка списка пользователей на страницы
    @users = User.paginate(page: page, per_page: 10).order(:login)
    sel = case params[:filter].to_sym
      when :students then User::ACCTYPES[:student]
      when :lecturers then User::ACCTYPES[:lecturer]
      when :mods then [User::ACCTYPES[:mod], User::ACCTYPES[:admin]]
    end
    # Фильтр пользователей (если указан)
    @users = @users.where(account_type: sel) if sel
    # Дабы не отображать удалённых пользователей
    @users = @users.where(removed: false)
  end


  def create_admin
    if request.get? then
      @user = User.new
    elsif request.post? then
      @user = User.new(params[:user])
      @user.account_type = User::ACCTYPES[:admin]
      if @user.save then
        session[:user_id] = @user.id
        redirect_to :root and return
      end
    end
  end

  def mods
    if request.get? then
      @mods = User.where(account_type: User::ACCTYPES[:mod])
      render 'admin/mods'
    elsif request.post? then
      @user = User.new
      @user.login = params[:login]
      @user.account_type = User::ACCTYPES[:mod]
      passwd = SecureRandom.base64(16)
      @user.password = @user.password_confirmation = passwd
      if @user.save then
        message = "Account. Login: #{@user.login}, password: #{passwd}"
        redirect_to :admin_mods, alert: message
      else
        redirect_to :admin_mods, notice: "Can't create"
      end
    elsif request.delete? then
      User.find(params[:id]).destroy
      redirect_to :admin_mods, alert: "Removed"
    end
  end

end