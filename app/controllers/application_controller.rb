class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
 
  private

  # Необходимо не иметь аккаунта администратора
  def shouldnt_have_admin_account
    if exists_admin_account? then
      redirect_to :root, :notice => t('messages.invalid_operation')
    end
  end

  # Необходимо быть неавторизированным
  def require_not_auth
    if logged? then
      redirect_to :root, :notice => t('messages.invalid_operation')
    end
  end

  # Необходима авторизация
  def require_auth
    unless logged? then
      redirect_to :login, :notice => t('messages.unauthorized')
    end
  end

  # Необходимо наличие прав администратора
  def require_admin_rights
    unless can_admin? then
      redirect_to :root, :notice => t('messages.invalid_operation')
    end
  end
end