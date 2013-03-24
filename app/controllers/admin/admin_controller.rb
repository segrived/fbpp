class Admin::AdminController < ApplicationController
  before_filter :require_admin_rights

  private

  def require_admin_rights
    redirect_to :root unless logged? && can_admin?
  end
end