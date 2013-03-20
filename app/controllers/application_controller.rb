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
    I18n.locale = params[:locale] || I18n.default_locale
  end
end