class AjaxController < ApplicationController

  # Количество непрочитанных сообщений
  def unread_messages_count
    render :json => { :count => unread_messages }
  end

end