class Admin::UsersController < Admin::AdminController

  # GET /admin/users/:page
  def list
    page = params[:page] || 1
    @users = User.paginate(:page => page, :per_page => 10).order('id DESC')
  end

  # PUT /admin/users/ban/:id/:banned
  def ban
    unless ['ban', 'unban'].include?(params[:banned]) then
      render :json => [ :success => false, :error => t('messages.bad_action') ]
      return false
    end

    if params[:id].to_i == logged_user.id then
      render :json => [ :success => false, :error => t('messages.cantbanself') ]
      return false
    end

    user = User.find(params[:id])
    user.banned = (params[:banned] == 'ban')
    status = user.save
    if request.xhr?
      if status
        render :json => [ :success => true ]
      else
        render :json => [ :success => false, :error => "Can't save" ]
      end
    end
  end

end