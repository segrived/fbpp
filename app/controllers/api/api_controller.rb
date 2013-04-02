class Api::ApiController < ApplicationController

  skip_before_filter :verify_authenticity_token

  before_filter :check_api_key, :only => [ :profile, :received_messages ]

  def render_error(error_text)
      render :json => [ :error => error_text ]
  end

  def get_api_key
    api_key = request.headers['__api_key']
    ApiKey.where(key: api_key).first
  end

  def check_api_key
    if ! get_api_key then
      render :json => { error: "Invalid API key" } and return
    end
    if Time.now > get_api_key.expiry_date then
      render :json => { error: "API key expiry" } and return
    end
  end

  def get_key
    login = request.headers['__login']
    password = request.headers['__password']
    unless user = User.authenticate(login, password) then
      render :json => { error: "Invalid credentials" } and return
    end
    k = ApiKey.new
    k.key = SecureRandom.hex(16)
    k.expiry_date = Time.now + 4.weeks
    k.user_id = user.id
    k.save
    render :json => { key: k.key }
  end

  def profile
    render :json => { user: get_api_key.user }
  end

  def received_messages
    render :json => { messages: get_api_key.user.received_messages }
  end

  def get_users
    render :json => { users: User.all }
  end

  def get_received_comments
    unless get_api_key.user.lecturer? then
      render :json => { error: "Invalid command" } and return
    end
    render :json => { comments: Lecturer.get_by_user(get_api_key.user).lecturer_comments.joins(:comment) }, :include =>  [:comment]
  end

end