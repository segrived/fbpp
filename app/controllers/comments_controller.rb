class CommentsController < ApplicationController

  before_filter :require_auth

  # POST /add_lecturer_comment
  def add_lecturer_comment
    comment = Comment.new
    comment.body = params[:body]
    comment.user_id = logged_user.id
    comment.anonymously = false
    comment.mark = params[:mark]
    comment.save
    lecturer_comment = LecturerComment.new
    lecturer_comment.lecturer_id = params[:lecturer_id]
    lecturer_comment.comment_id = comment.id
    lecturer_comment.save
    redirect_to :back
  end

  # DELETE /lecturer/comments/:comment_id/delete
  def delete_lecturer_comment
    lc = LecturerComment.where(id: params[:comment_id]).first
    # Если указанный комментарий не найден
    redirect_to :back and return unless lc
    # Удалить комментарий может только администратор или пользователь
    # с правами администратора
    unless can_admin? || lc.comment.user_id == logged_user.id then
      redirect_to :back and return
    end
    # Удаление самого комментария
    lc.comment.destroy
    # Удаление из связывающей таблицы
    lc.destroy
    redirect_to :back, notice: t('messages.comment_has_been_removed')
  end

end