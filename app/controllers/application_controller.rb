class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper

  before_filter :set_locale
 
  private

  def require_not_auth
    if logged?
      redirect_to :root
    end
  end

  def require_login
    unless logged?
      redirect_to :login, :notice => tc('messages.unauthorized')
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