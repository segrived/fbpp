class CommentsController < ApplicationController

  before_filter :require_auth

  # POST /comments/add
  def add
    comment = Comment.new
    comment.body = params[:body]
    comment.user_id = logged_user.id
    comment.anonymously = params[:anonymously].eql?(nil)
    comment.mark = params[:mark]
    comment.save
    lecturer_comment = LecturerComment.new
    lecturer_comment.lecturer_id = params[:lecturer_id]
    lecturer_comment.comment_id = comment.id
    lecturer_comment.save
    redirect_to :back
  end

  # DELETE /comments/:comment_id/delete
  def destroy
    lc = LecturerComment.where(id: params[:comment_id]).first
    # Если указанный комментарий не найден
    render_404 and return unless lc
    # Удалить комментарий может только администратор, пользователь
    # с правами администратора или автор
    unless can_admin? || lc.comment.user_id == logged_user.id then
      render_403 and return
    end
    # Удаление комментария
    lc.destroy
    redirect_to :back, notice: t('messages.comment_has_been_removed')
  end

end