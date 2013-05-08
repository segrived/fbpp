class SessionsController < ApplicationController

  before_filter :require_auth, :except => [:login, :profile]
  before_filter :require_not_auth, :only => :login

  # GET /logout
  def logout
    clear_user_session
    redirect_to :root
  end

end