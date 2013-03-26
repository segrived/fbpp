class Admin::UsersController < Admin::AdminController

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