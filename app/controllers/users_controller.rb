class UsersController < ApplicationController

  def new
    @user = User.new
    render :register
  end

  def create
    @user = User.new(params[:user])
    # Простой смертный не может зарегистрировать администратора или модератора
    if User.in_admin_group?(@user) then
      redirect_to :login, :notice => t('messages.invalid_operation') and return
    end
    
    if @user.save then
      # Создание записи в дополнительной таблице
      if @user.student? then
        Student.create(:user_id => @user.id)
      elsif @user.lecturer? then
        Lecturer.create(:user_id => @user.id,
          :confirm_level => Lecturer::CONFIRM_LEVELS[:unconfirmed])
      end
      login, password = params[:user][:login], params[:user][:password]
      session[:user] = User.authenticate(login, password)
      redirect_to :my_options
    else
      render :register
    end
  end

end