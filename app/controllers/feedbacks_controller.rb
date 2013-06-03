class FeedbacksController < ApplicationController

  def new
    @question = Question.all
    @subscription = SubjectSubscription.find(params[:id])
  end

  def add
    unless logged_user.student.can_add_feedback(params[:id])
      render_403 and return
    end
    feedback = Feedback.new(
      student_id: logged_user.student.id,
      subject_subscription_id: params[:id],
      time: Time.now)
    feedback.save
    answered = JSON.parse(params[:answers]).map { |h| h['qid'] }.uniq
    required_questions = Question.where(required: true).collect(&:id)
    # Должны быть даны ответы на все обязательные вопросы
    if (required_questions & answered).count != required_questions.count
      render_403 and return
    end
    JSON.parse(params[:answers]).each do |a|
      FeedbackAnswer.create(feedback_id: feedback.id, question_id: a['qid'], answer: a['answer'])
    end
    if params[:comment] then
      comment = Comment.new(params[:comment])
      comment.user_id = logged_user.id
      comment.save
      FeedbackComment.create(feedback_id: feedback.id, comment_id: comment.id)
    end
    render json: {status: true}
  end

  def destroy
    feedback = Feedback.find(params[:id])
    if can_admin? || (logged_user.student? && feedback.student_id = logged_user.student.id)
     Feedback.find(params[:id]).destroy
     redirect_to :back
    else
      render_403
    end
  end

end