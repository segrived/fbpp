class Admin::ConfigsController < Admin::BaseAdminController

  def index
  end

  def save
    SiteGlobal.invite_reg = !!params[:invite_reg]
    SiteGlobal.enable_api = !!params[:enable_api]
    redirect_to :back, alert: "Saved!"
  end

end