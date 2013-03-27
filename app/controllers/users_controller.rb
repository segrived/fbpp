class UsersController < ApplicationController

  before_filter :shouldnt_have_admin_account, :only => :create_admin_account

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
      session[:user_id] = User.authenticate(login, password).id
      redirect_to :my_options
    else
      render :register
    end
  end

  def create_admin_account
    if request.get? then
      @user = User.new
    elsif request.post? then
      @user = User.new(params[:user])
      @user.account_type = User::ACCTYPES[:admin]
      login, password = params[:user][:login], params[:user][:password]
      session[:user_id] = User.authenticate(login, password)
      redirect_to :root and return if @user.save
    end
  end

  # GET /admin/users/:page
  def list
    filter = params[:filter] ? params[:filter].to_sym : :all
    unless User::ACCTYPES.include?(filter) || filter == :all then
      redirect_to admin_users_path(:all) and return
    end
    @users = User.paginate(:page => (params[:page] || 1), :per_page => 10)
    if filter != :all
      @users = @users.where("account_type = ?", User::ACCTYPES[filter])
    end
  end

end