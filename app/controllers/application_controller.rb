class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper

  before_filter :set_locale
 
  private

  def shouldnt_have_admin_account
    redirect_to :root, :notice => t('messages.invalid_operation') if exists_admin_account?
  end

  def require_not_auth
    redirect_to :root, :notice => t('messages.invalid_operation') if logged?
  end

  def require_login
    unless logged?
      redirect_to :login, :notice => t('messages.unauthorized')
    end
  end

  def set_locale
    locale = I18n.default_locale
    if cookies[:locale] then
      locale = cookies[:locale] if I18n.available_locales.include?(cookies[:locale].to_sym)
    end
    I18n.locale = locale
  end
end