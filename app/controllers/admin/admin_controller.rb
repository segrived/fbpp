class Admin::AdminController < ApplicationController
  before_filter :require_admin_rights

  private

  def require_admin_rights
    unless logged? && can_admin? then
      redirect_to :root
    end
  end
end