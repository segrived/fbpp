class FeedbacksController < ApplicationController

  def new
    @question = Question.all
  end

  def add
    feedback = Feedback.new(
      student_id: logged_user.student.id,
      subject_subscription_id: params[:id],
      time: Time.now)
    feedback.save
    JSON.parse(params[:answers]).each do |answer| do
      
    end
  end

end