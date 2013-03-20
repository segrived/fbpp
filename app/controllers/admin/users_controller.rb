class Admin::UsersController < Admin::AdminController

  def list
    @users = User.all
  end

  def ban
    @user = User.find(params[:id])
    @user.banned = true
    @user.save
  end

end