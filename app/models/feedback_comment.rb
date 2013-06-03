class FeedbackComment < ActiveRecord::Base
  belongs_to :feedback
  belongs_to :comment
  attr_accessible :feedback_id, :comment_id
end
