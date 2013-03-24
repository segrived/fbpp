class SessionsController < ApplicationController

  before_filter :require_login, :only => [:options, :change_password, :logout]
  before_filter :require_not_auth, :only => :login

  # GET /login
  # POST /login
  def login
    # Если пришел GET-запрос - просто отображаем форму
    if request.get? then
      render 'login'
      return false
    end
    # Пытаемся авторизироваться на основе введённых данных
    login, password = params[:login], params[:password]

    unless user = User.authenticate(login, password)
      redirect_to :login, :notice => t('messages.bad_login')
      return false
    end

    if user.banned then
      redirect_to :login, :notice => t('messages.banned')
      return false
    end

    session[:user] = user
    redirect_to :root
  end

  # GET /logout
  def logout
    session[:user] = nil
    redirect_to :root
  end

  # GET /profile/(:id)
  def profile
    if params[:login] == nil && !logged? then
      redirect_to :root
      return false
    end
    login = params[:login] || logged_user.login
    @user = User.find_by_login(login)
  end

  # GET /my/set_user_locale
  def set_user_locale
     cookies[:locale] = params[:locale]
     redirect_to :profile
  end

  # GET /my/options
  def options
    # Дополнительные опции доступны только для студентов и преподавателей
    unless logged_user.student? || logged_user.lecturer? then
      redirect_to :profile
      return false
    end
    if request.get? then
      render 'options'
      return false
    end
    if logged_user.student?
      obj = Student.find_by_user_id(logged_user.id)
      obj.course = params[:course]
      obj.specialty_id = params[:specialty]
    elsif logged_user.lecturer?
      obj = Lecturer.find_by_user_id(logged_user.id)
      obj.departament_id = params[:departament]
      obj.scientific_degree_id = params[:degree]
    end
    obj.user_id = logged_user.id
    if obj.save then
      redirect_to :profile
    else
      redirect_to :my_options, :notice => t('messages.invalid_operation')
    end
  end

  # GET /my/change_password
  # PUT /my/change_password
  def change_password
    @user = User.find(logged_user.id)
    if request.get? then
      render :change_password
      return false
    end

    if request.put? then
      attributes = {
        :password => params[:user][:password],
        :password_confirmation => params[:user][:password_confirmation]
      }
      if @user.update_attributes(attributes) then
        redirect_to :profile
      else
        render :change_password
      end
    end
  end
end