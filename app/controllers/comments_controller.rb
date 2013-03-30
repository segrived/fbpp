class CommentsController < ApplicationController

  # POST /add_comment/:user_id
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

end