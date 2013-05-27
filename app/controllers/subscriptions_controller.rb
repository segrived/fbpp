class SubscriptionsController < ApplicationController

  def show
    @subscription = SubjectSubscription.find(params[:id])
  end

  def all
    page = params[:page] || 1
    @feedbacks = SubjectSubscription
      .find(params[:id])
      .feedbacks
      .order('time DESC')
      .paginate(page: page, per_page: 10)
  end
    
end