class SessionsController < ApplicationController

  before_filter :require_auth

  # GET /logout
  def logout
    clear_user_session
    redirect_to :root
  end

end