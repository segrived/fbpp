module SessionsHelper
  def logged?
    session[:user] != nil
  end

  def logged_user
    session[:user]
  end
end
