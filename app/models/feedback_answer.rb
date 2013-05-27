class FeedbackAnswer < ActiveRecord::Base
  belongs_to :feedback
  belongs_to :question
  attr_accessible :answer, :feedback_id, :question_id

  validates :question_id, existence: true
  validates :feedback_id, existence: true
  validates :answer, inclusion: { in: 1 .. 5 }
end
