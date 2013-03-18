class SessionsController < ApplicationController

  before_filter :require_login, :only => [:profile, :logout]
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
end