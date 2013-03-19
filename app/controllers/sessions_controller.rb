class SessionsController < ApplicationController

  before_filter :require_login, :only => [:logout, :options]
  before_filter :require_not_auth, :only => :login

  def login
    # Если пришел GET-запрос - просто отображаем форму
    if request.get? then
      render 'login'
      return false
    end
    # Пытаемся авторизироваться на основе введённых данных
    login, password = params[:login], params[:password]
    if session[:user] = User.authenticate(login, password) then
      redirect_to :root
    else
      redirect_to :login, :notice => tc('messages.badLogin')
    end
  end

  def logout
    session[:user] = nil
    redirect_to :root
  end

  def profile
    login = params[:login] || logged_user.login 
    @user = User.find_by_login(login)
  end

  def options
    if request.get? then
      render 'options'
      return false
    end
    if logged_user.student?
      obj = Student.find_or_create_by_user_id(logged_user.id)
      obj.course = params[:course]
      obj.specialty_id = params[:specialty]
    elsif logged_user.lecturer?
      obj = Lecturer.find_or_create_by_user_id(logged_user.id)
      obj.departament_id = params[:departament]
      obj.scientific_degree_id = params[:degree]
    end
    obj.user_id = logged_user.id
    if obj.save then
      redirect_to :root
    else
      redirect_to :options, :notice => "bad"
    end
  end
end