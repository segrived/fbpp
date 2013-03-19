class UsersController < ApplicationController

  before_filter :require_not_auth

  def new
    @user = User.new
    render :register
  end

  def create
    @user = User.new(params[:user])
    if @user.save then
      # Создание записи в дополнительной таблице
      if @user.student? then
        Student.create(:user_id => @user.id)
      elsif @user.lecturer? then
        Lecturer.create(:user_id => @user.id)
      end
      login, password = params[:user][:login], params[:user][:password]
      session[:user] = User.authenticate(login, password)
      redirect_to :my_options
    else
      render :register
    end
  end

end