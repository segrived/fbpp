class UsersController < ApplicationController

  def new
    @user = User.new
    render 'register'
  end

  def create
    @user = User.new(params[:user])
    if @user.save then
      login, password = params[:user][:login], params[:user][:password]
      session[:user] = User.authenticate(login, password)
      redirect_to :root
    else
      render :register
    end
  end

end