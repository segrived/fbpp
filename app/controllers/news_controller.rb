class NewsController < ApplicationController

  before_filter :require_admin_rights, only: [:new, :create]

  def new
    @news_item = NewsItem.new
  end

  def create
    @news_item = NewsItem.new(params[:news_item])
    @news_item.user_id = logged_user.id
    if @news_item.save then
      redirect_to :root
    else
      redirect_to :root, notice: "Error"
    end
  end

  def destroy
    NewsItem.find(params[:id]).destroy
    redirect_to :back, alert: "Removed!"
  end

end
