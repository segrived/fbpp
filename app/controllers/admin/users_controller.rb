class Admin::UsersController < Admin::AdminController

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

  # PUT /admin/users/ban/:id/:banned
  def ban
    unless ['ban', 'unban'].include?(params[:banned]) then
      render :json => [ :success => false,
        :error => t('messages.bad_action') ] and return
    end

    if params[:id].to_i == logged_user.id then
      render :json => [ :success => false,
        :error => t('messages.cantbanself') ] and return
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