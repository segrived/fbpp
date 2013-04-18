class CommentVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment
  attr_accessible :user_id, :comment_id, :vote, :vote_time

  before_save :set_vote_time

  def set_vote_time
    self.vote_time = Time.now
  end
end