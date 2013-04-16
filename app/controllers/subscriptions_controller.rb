class SubscriptionsController < ApplicationController

  def show
    @subscription = SubjectSubscription.find(params[:id])
  end
    
end