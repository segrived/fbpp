class Admin::InvitesController < Admin::BaseAdminController

  def index
    page = params[:page] || 1
    @invites = Invite.paginate(per_page: 50, page: page).all
  end

  def new
    render :new
  end

  def create
    invites = []
    expires = params[:expires].present? ? params[:expires] : nil
    # Не разрешать создавать более 50 инвайтов за один раз
    if params[:count].to_i > 50 then
      render :new and return
    end
    params[:count].to_i.times do |i| 
      invites << Invite.new(code: Invite.generate_new, remains: params[:remains], expires: expires)
    end
    if Invite.import invites then
      redirect_to :admin_invites
    end
  end

  def cleanup
    Invite.destroy_all
    redirect_to :back
  end
  
end