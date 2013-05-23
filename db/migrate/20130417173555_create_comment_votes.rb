class CreateCommentVotes < ActiveRecord::Migration
  def change
    create_table :comment_votes do |t|
      t.references :user
      t.references :lecturer_comment
      t.integer :vote
      t.datetime :vote_time

      t.timestamps
    end
    add_index :comment_votes, :user_id
    add_index :comment_votes, :lecturer_comment_id
  end
end
