class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
 
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  before_filter :disable_sidebar!, only: [:render_403, :render_404]

  def enable_sidebar!
    @has_sidebar = true
  end

  def disable_sidebar!
    @has_sidebar = false
  end

  protected

  def render_403
    respond_to do |format|
      format.html { render "errors/403", status: 403 }
      format.json { render json: { error: true, message: "403 Not authorized" } }
    end
  end

  def render_404
    respond_to do |format|
      format.html { render "errors/404", status: 404 }
      format.json { render json: { error: true, message: "404 Not Found" } }
    end
  end

  private

  # Необходимо не иметь аккаунта администратора
  def shouldnt_have_admin_account
      render_403 if exists_admin_account?
  end

  # Необходимо быть неавторизированным
  def require_not_auth
    render_403 if logged?
  end

  # Необходима авторизация
  def require_auth
    render_403 unless logged?
  end

  # Необходимо наличие прав администратора
  def require_admin_rights
    render_403 unless can_admin?
  end

  def require_admin_account
    render_403 unless logged_user.admin?
  end
end