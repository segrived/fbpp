class SessionsController < ApplicationController
  def login
    # Если пользователь уже залогинен - перебрасываем его на главную страницу
    if session[:user] then
      redirect_to my_path
      return false
    end

    if request.post? then
        login, password = params[:login], params[:password]
        if session[:user] = User.authenticate(login, password) then
          redirect_to :controller => 'welcome', :action => 'index'
        else
          flash.now[:message] = "Invalid login or password"
          render 'login'
        end
    else
        render 'login'
    end
  end

  def logout
    session[:user] = nil
    redirect_to index_path
  end

  def profile
  end
end
