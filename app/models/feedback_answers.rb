class FeedbackAnswers < ActiveRecord::Base
  belongs_to :feedback
  belongs_to :question
  attr_accessible :answer, :feedback_id, :question_id
end
