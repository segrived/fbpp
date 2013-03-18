class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper

  before_filter :set_locale
 
  def require_not_auth
    if logged?
      redirect_to :root
    end
  end

  def require_login
    unless logged?
      flash[:notice] = tc('messages.unauthorized')
      redirect_to :login
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end