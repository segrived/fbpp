class UsersController < ApplicationController

  before_filter :require_not_auth

  def new
    @user = User.new
    render 'register'
  end

  def create
    @user = User.new(params[:user])
    if @user.save then
      login, password = params[:user][:login], params[:user][:password]
      session[:user] = User.authenticate(login, password)
      redirect_to :my_options
    else
      render :register
    end
  end

end