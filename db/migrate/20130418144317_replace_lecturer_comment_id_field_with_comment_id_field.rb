class ReplaceLecturerCommentIdFieldWithCommentIdField < ActiveRecord::Migration
  def change
    rename_column :comment_votes, :lecturer_comment_id, :comment_id
  end
end
