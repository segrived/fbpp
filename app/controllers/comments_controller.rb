class CommentsController < ApplicationController

  before_filter :require_auth

  # POST /comments/add
  def add
    comment = Comment.new(params[:comment])
    comment.attributes = {
      user_id: logged_user.id,
      anonymously: params[:comment][:anonymously].eql?(nil)
    }
    comment.save
    redirect_to :back
  end

  # DELETE /comments/:comment_id/delete
  def destroy
    comment = Comment.find!(params[:comment_id])
    # Удалить комментарий может только администратор, пользователь
    # с правами администратора или автор
    if (! can_admin?) || comment.user_id != logged_user.id then
      render_403 and return
    end
    # Удаление комментария
    comment.destroy
    redirect_to :back, notice: t('messages.comment_has_been_removed')
  end

  # POST /comments/:comment_id/upvote
  def vote
    # Нельзя голосовать за свои комментарии
    if Comment.find(params[:comment_id]).user == logged_user then
      render_403 and return
    end
    # Голосовать за комментарии могут только студенты
    render_403 and return unless logged_user.student?
    vote = params[:type].eql?('upvote') ? 1 : -1
    cv = CommentVote.where(
      comment_id: params[:comment_id],
      user_id: logged_user.id).first_or_create
    cv.update_attributes({ vote: vote })
    redirect_to :back
  end


end